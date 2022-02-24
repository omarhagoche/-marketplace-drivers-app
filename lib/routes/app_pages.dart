import 'package:get/get_navigation/src/routes/get_route.dart';

import '../presintation/home/home_binding.dart';
import '../presintation/home/home_controller.dart';
import '../presintation/home/home_screen.dart';
import '../presintation/login/login_binding.dart';
import '../presintation/login/login_screen.dart';
import '../presintation/orders/orders_binding.dart';
import '../presintation/orders/orders_screen.dart';
import '../presintation/orders_history/orders_history_binding.dart';
import '../presintation/orders_history/orders_history_screen.dart';
import '../presintation/profile/profile_binding.dart';
import '../presintation/profile/profile_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
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
        name: Routes.ORDERS,
        page: () =>  OrdersScreen(),
        binding: OrdersBinding()
    ),
    GetPage(
        name: Routes.ORDERS_HISTORY,
        page: () =>  OrdersHistoryScreen(),
        binding: OrderHistoryBinding()
    ),

  ];
}
