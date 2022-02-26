import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'ar.dart';
import 'en.dart';

class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('ar', '');

  static final langs = [
    'en_US',
    'ar',
  ];

  static final locales = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', ''),
  };

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    Get.find<GetStorage>().write('language', lang);
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  //set Default Language
  Future<void> setDefaultLanguage(String language) async {
    await Get.find<GetStorage>().write('language', language);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String lang) {
    if (locales.containsKey(lang)) {
      return locales[lang];
    } else
      return Get.locale;
  }
}
