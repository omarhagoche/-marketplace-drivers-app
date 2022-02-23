import 'package:get/get.dart';
import 'tracking_controller.dart';

class TrackingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingController>(() => TrackingController());
  }
}