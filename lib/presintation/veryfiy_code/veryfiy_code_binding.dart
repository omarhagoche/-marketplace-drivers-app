import 'package:get/get.dart';

import 'veryfiy_code_controller.dart';

class VeryfiyCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VeryfiyCodeController>(() => VeryfiyCodeController());
  }
}