import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../core/utils/custom_trace.dart';
import '../../data/models/route_argument.dart';
import '../../data/repositories/settings_repository.dart';
import '../../src/elements/notification_icon.dart';

class SplashController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

 @override
  void onInit() {
    super.onInit();
    if (Platform.isIOS) {
      firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
    registerNotification();

  }

  void registerNotification() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('onMessage : ${message.notification!.title!}');
        showSimpleNotification(
          Text(message.notification!.title!),
          subtitle: Text(
            message.notification!.body!,
          ),
          leading: NotificationIcon(),
          background: Colors.deepPurple,
          duration: Duration(seconds: 4),
        );
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if(message.data['id']!=null)
          navigatorKey.currentState!.pushReplacementNamed(
              '/OrderDetailsNot',
              arguments: RouteArgument(id: message.data['id'].toString()));
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      message) async {
    print('onBackgroundMessage : ${message.notification!.title!}');
    showSimpleNotification(
      Text(message.notification!.title!),
      subtitle: Text(
        message.notification!.body!,
      ),
      leading: NotificationIcon(),
      background: Colors.deepPurple,
      duration: Duration(seconds: 4),
    );
  }
}
