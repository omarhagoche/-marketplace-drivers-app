
import 'package:get/get.dart';

import 'home_controller.dart';

class HomedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}