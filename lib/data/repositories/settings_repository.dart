import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import '../../routes/app_pages.dart';
import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import '../models/address.dart';
import '../models/setting.dart';
import '../models/user.dart';
import '../services/api/api_service.dart';
import 'auth_repository.dart';
import 'user_repository.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<bool> workingOnOrder = new ValueNotifier(false);
ValueNotifier<Address> myAddress = new ValueNotifier(new Address());
final navigatorKey = GlobalKey<NavigatorState>();
const Privacy_Policy = 'https://cp.sabek.app/privacy';
const APP_STORE_URL =
    'https://apps.apple.com/gb/app/sabek-partner/id1600324402?uo=2';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=ly.sabek.delivery';

class SettingRepository extends ApiService {
  static SettingRepository get instance => SettingRepository();
  final box = Get.find<GetStorage>();

  Future<Setting> initSettings() async {
    dynamic responseBody;
    final String url = 'settings';
    await get(
      url,
    ).then((response) async {
      if (response.statusCode == 200) {
        responseBody = Setting.fromJSON(response.data['data']);
        setting.value = responseBody;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');
      responseBody = new Setting();
    });
    return responseBody;
  }

  listenCurrentLocation() async {
    if (!Get.find<GetStorage>().hasData('permission'))
      setValue('acceptPermission');
    User user = new User();
    String? driverId;
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    double startLatitude = 0;
    double startLongitude = 0;
    double distanceInMeters;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (Get.find<GetStorage>().hasData('token'))
      UserRepository.instance.userProfile().then(
            (value) => location.onLocationChanged.listen(
              (LocationData current) {
                try {
                  if (driverId == null) {
                    FirebaseFirestore.instance
                        .collection("drivers")
                        .doc(currentUser.value.id)
                        .get()
                        .then(
                      (driver) {
                        driverId = driver['id'].toString();
                        workingOnOrder.value = driver['working_on_order'];

                        FirebaseFirestore.instance
                            .collection("drivers")
                            .doc(currentUser.value.id)
                            .set(
                          {
                            'id': currentUser.value.id,
                            'available': false,
                            'working_on_order': false,
                            'latitude': current.latitude,
                            'longitude': current.longitude,
                            'last_access': DateTime.now().millisecondsSinceEpoch
                          },
                        ).catchError(
                          (e) {
                            print(e);
                          },
                        );
                        startLatitude = current.latitude!;
                        startLongitude = current.longitude!;
                      },
                    );
                  } else {
                    distanceInMeters = Geolocator.distanceBetween(
                      startLatitude,
                      startLongitude,
                      current.latitude!,
                      current.longitude!,
                    );

                    if (distanceInMeters >= 100) {
                      FirebaseFirestore.instance
                          .collection("drivers")
                          .doc(currentUser.value.id)
                          .update(
                        {
                          'id': currentUser.value.id,
                          'latitude': current.latitude,
                          'longitude': current.longitude,
                          'last_access': DateTime.now().millisecondsSinceEpoch
                        },
                      ).catchError(
                        (e) {
                          print(e);
                        },
                      );
                      startLatitude = current.latitude!;
                      startLongitude = current.longitude!;
                    }
                  }
                } catch (e) {
                  print("Error in cloud firebase $e");
                }
              },
            ),
          );
    location.enableBackgroundMode(enable: true);
  }

  Future<void> setValue(value) async {
    if (value != null) {
      await box.write('permission', value);
    }
  }

  Future<void> setDefaultLanguage(String language) async {
    await box.write('language', language);
  }

  Future<String> getDefaultLanguage(String defaultLanguage) async {
    if (box.read('language') != null) {
      defaultLanguage = await box.read('language');
    }
    return defaultLanguage;
  }

  Future<void> saveMessageId(String messageId) async {
    await box.write('google.message_id', messageId);
  }

  Future<String> getMessageId() async {
    return await box.read('google.message_id');
  }

  versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion =
        double.parse(info.version.trim().replaceAll(".", ""));
    Platform.isIOS
        ? {
            if (double.tryParse(
                    setting.value.appVersionIOS!.replaceAll(".", ""))! >
                currentVersion)
              {
                if (setting.value.forceUpdateIOS!)
                  Get.offAndToNamed(Routes.FORCEUPDATE,
                      arguments: RouteArgument(id: ''))
                else
                  {
                    Get.offAndToNamed(Routes.FORCEUPDATE,
                        arguments: RouteArgument(id: '0'))
                  }
              }
            else
              Get.offAndToNamed(Routes.HOME, arguments: 0)
          }
        : {
            if (double.tryParse(
                    setting.value.appVersionAndroid!.replaceAll(".", ""))! >
                currentVersion)
              {
                if (setting.value.forceUpdateAndroid!)
                  Get.offAndToNamed(Routes.FORCEUPDATE,
                      arguments: RouteArgument(id: ''))
                else
                  {
                    Get.offAndToNamed(Routes.FORCEUPDATE,
                        arguments: RouteArgument(id: '0'))
                  }
              }
            else
              Get.offAndToNamed(Routes.HOME, arguments: 0)
          };
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
