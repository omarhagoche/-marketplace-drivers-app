import 'package:get/get_navigation/src/routes/get_route.dart';

import '../presintation/login/login_binding.dart';
import '../presintation/login/login_screen.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
     GetPage(
       name: Routes.LOGIN,
       page: () => const LoginScreen(),
       binding: LoginBinding()
     ),

  ];
}
