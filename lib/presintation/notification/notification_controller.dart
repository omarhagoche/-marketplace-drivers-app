import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/notification.dart' as model;
import '../../data/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final unReadNotificationsCount = 0.obs;
  final notifications = <model.Notification>[].obs;
  final notification = model.Notification().obs;
  late GlobalKey<ScaffoldState> scaffoldKey;


  @override
  void onInit() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForNotifications();
    super.onInit();
  }


  void listenForNotifications({String? message}) async {
    try {
      final List<model.Notification> _notification =
      await NotificationRepository.instance.getNotifications();
      notifications.assignAll(_notification);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(message: "Notifications_refreshed_successfully".tr);
  }

  void removeFromNotification(model.Notification _notification) async {
    try {
      notifications.remove(_notification);
      update();
      NotificationRepository.instance.removeNotification(_notification).then((value) {
        Get.snackbar('', "This_notification_was_removed".tr);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void doMarkAsReadNotifications(model.Notification _notification) async {
    try {
      NotificationRepository.instance.markAsReadNotifications(_notification).then((value) {
        --unReadNotificationsCount.value;
        _notification.read = !_notification.read!;
        update();
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text('this_notification_has_marked_AsRead'.tr),
        ));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void doMarkAsUnReadNotifications(model.Notification _notification) {
    try {
      NotificationRepository.instance.markAsReadNotifications(_notification).then((value) {
        ++unReadNotificationsCount.value;
        _notification.read = !_notification.read!;
        update();
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text('this_notification_has_marked_AsUnread'.tr),
        ));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void doRemoveNotification(model.Notification _notification) async {
    try {
      NotificationRepository.instance.removeNotification(_notification).then((value) {
        if (!_notification.read!) {
          --unReadNotificationsCount.value;
        }
        this.notifications.remove(_notification);
        update();
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text('This_notification_was_removed'.tr),
        ));
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
