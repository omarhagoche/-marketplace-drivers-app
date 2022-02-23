import 'package:get/get.dart';
import 'faq_controller.dart';

class FaqBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FaqController>(() => FaqController());
  }
}