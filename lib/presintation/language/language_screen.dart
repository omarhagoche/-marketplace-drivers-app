import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/values/colors.dart';
import '../../translation/lang_service.dart';
import 'language_controller.dart';

class LanguageScreen extends GetView<LanguageController> {

  @override
  Widget build(BuildContext context) {
    Locale locale;
    if (Get.find<GetStorage>().hasData('language')) {
      locale = LocalizationService().getLocaleFromLanguage(Get.find<GetStorage>().read('language')) ?? LocalizationService.locale;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('languages'.tr),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                boxShadow: [
                  BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                ],
                border: Border.all(color: Get.theme.focusColor.withOpacity(0.05)),
              ),
              child: Column(
                children: List.generate(LocalizationService.langs.length, (index) {
                  var _lang = LocalizationService.langs.elementAt(index);
                  return RadioListTile(
                    value: _lang,
                    groupValue: Get.locale.toString(),
                    onChanged: (value) {
                      controller.updateLocale(value);
                    },
                    title: Text(_lang.tr, style: Get.textTheme.bodyText2),
                  );
                }).toList(),
              ),
            )
          ],
        ));
  }
}
