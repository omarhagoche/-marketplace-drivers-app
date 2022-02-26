import 'package:get/get.dart';

import 'reset_password_controller.dart';

class RestPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}