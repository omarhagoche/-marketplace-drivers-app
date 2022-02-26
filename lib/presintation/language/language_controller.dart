import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final _box = Get.find<GetStorage>();

  void updateLocale(value) async {
    if (value.contains('_')) {
      // en_US
      Get.updateLocale(Locale(value.split('_').elementAt(0), value.split('_').elementAt(1)));
    } else {
      // ar
      Get.updateLocale(Locale(value));
    }
    await _box.write('language', value);
  }
}
