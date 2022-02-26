import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/values/colors.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'package:overlay_support/overlay_support.dart';
import 'routes/app_pages.dart';
import 'translation/lang_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  Get.put<GetStorage>(GetStorage());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Locale locale;
    if (Get.find<GetStorage>().hasData('language')) {
      locale = LocalizationService()
              .getLocaleFromLanguage(Get.find<GetStorage>().read('language')) ??
          LocalizationService.locale;
    } else {
      LocalizationService().setDefaultLanguage('ar');
      locale = LocalizationService()
              .getLocaleFromLanguage(Get.find<GetStorage>().read('language')) ??
          LocalizationService.locale;
    }
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => OverlaySupport.global(
        child: GetMaterialApp(
          onInit: () {
            ///Some problem in initSettings repo
            SettingRepository.instance.initSettings();
            AuthRepository.instance.getCurrentUser();
          },
          title: "Sabek",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Tajawal',
            primaryColor: white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
            brightness: Brightness.light,
            accentColor: primaryColor,
            dividerColor: accentColor.withOpacity(0.1),
            focusColor: accentColor,
            hintColor: secondaryColor,
            appBarTheme: AppBarTheme(color: primaryColor),
            scaffoldBackgroundColor: backgroundColor,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          locale: locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        ),
      ),
    );
  }
}
