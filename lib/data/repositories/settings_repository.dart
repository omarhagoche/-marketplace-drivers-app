import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import '../models/address.dart';
import '../models/setting.dart';
import '../services/api/api_service.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
ValueNotifier<Address> myAddress = new ValueNotifier(new Address());
final navigatorKey = GlobalKey<NavigatorState>();
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
      print('categories:${response.statusCode}');
      print('categories:${response.data['data']}');
      if (response.statusCode == 200) {
        if (json.decode(response.data)['data'] != null) {
          // box.write('settings', json.encode(response.data['data']));
          responseBody = Setting.fromJSON(json.decode(response.data)['data'] as Map<String,dynamic>);
          // if (box.read('language')) {
          //   _setting.mobileLanguage = new ValueNotifier(Locale(box.read('language'), ''));
          // }
         // _setting.brightness!.value =
          // box.read('isDark') ?? false ? Brightness.dark : Brightness.light;
          setting.value = responseBody;
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          setting.notifyListeners();
        }
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');
      responseBody=new Setting();
    });
    return responseBody;
  }


  Future<void> setDefaultLanguage(String language) async {
    if (language != null) {
      await box.write('language', language);
    }
  }

  Future<String> getDefaultLanguage(String defaultLanguage) async {
    if (box.read('language') != null) {
      defaultLanguage = await box.read('language');
    }
    return defaultLanguage;
  }

  Future<void> saveMessageId(String messageId) async {
    if (messageId != null) {
      await box.write('google.message_id', messageId);
    }
  }

  Future<String> getMessageId() async {
    return await box.read('google.message_id');
  }
  versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(
        info.version.trim().replaceAll(".", ""));
    Platform.isIOS
        ? {
      if (double.tryParse(setting.value.appVersionIOS!.replaceAll(".", ""))! >
          currentVersion)
        {
          if (setting.value.forceUpdateIOS!)
            Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                arguments: RouteArgument(id: ''))
          else
            {
              Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                  arguments: RouteArgument(id: '0'))
            }
        }
      else
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0)
    }
        : {
      if (double.tryParse(
          setting.value.appVersionAndroid!.replaceAll(".", ""))! >
          currentVersion)
        {
          if (setting.value.forceUpdateAndroid!)
            Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                arguments: RouteArgument(id: ''))
          else
            {
              Navigator.of(context).pushReplacementNamed('/ForceUpdate',
                  arguments: RouteArgument(id: '0'))
            }
        }
      else
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 0)
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