import 'package:get/get_navigation/src/routes/get_route.dart';
import '../presintation/faq/faq_binding.dart';
import '../presintation/faq/faq_screen.dart';
import '../presintation/home/home_binding.dart';
import '../presintation/home/home_screen.dart';
import '../presintation/language/language_binding.dart';
import '../presintation/language/language_screen.dart';
import '../presintation/login/login_binding.dart';
import '../presintation/login/login_screen.dart';
import '../presintation/notification/notification_binding.dart';
import '../presintation/notification/notification_screen.dart';
import '../presintation/orders/orders_binding.dart';
import '../presintation/orders/orders_screen.dart';
import '../presintation/orders_history/orders_history_binding.dart';
import '../presintation/orders_history/orders_history_screen.dart';
import '../presintation/profile/profile_binding.dart';
import '../presintation/profile/profile_screen.dart';
import '../presintation/setting/setting_binding.dart';
import '../presintation/setting/setting_screen.dart';
import '../presintation/splash/splash_binding.dart';
import '../presintation/splash/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
     GetPage(
       name: Routes.LOGIN,
       page: () =>  LoginScreen(),
       binding: LoginBinding()
     ),
    GetPage(
        name: Routes.HOME,
        page: () =>  HomeScreen(),
        binding: HomedBinding()
    ),
    GetPage(
        name: Routes.PROFILE,
        page: () =>  ProfileScreen(),
        binding: ProfileBinding()
    ),
    GetPage(
        name: Routes.LANGUAGE,
        page: () =>  LanguageScreen(),
        binding: LanguageBinding()
    ),

    GetPage(
        name: Routes.ORDERS,
        page: () =>  OrdersScreen(),
        binding: OrdersBinding()
    ),
    GetPage(
        name: Routes.ORDERS_HISTORY,
        page: () =>  OrdersHistoryScreen(),
        binding: OrderHistoryBinding()
    ),
    GetPage(
        name: Routes.HELP,
        page: () =>  FaqScreen(),
        binding: FaqBinding()
    ), GetPage(
        name: Routes.NOTIFICATION,
        page: () =>  NotificationScreen(),
        binding: NotificationBinding()
    ),
    GetPage(
        name: Routes.SETTING,
        page: () =>  SettingScreen(),
        binding: SettingBinding()
    ),

  ];
}
