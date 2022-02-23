import 'package:get/get.dart';
import 'order_details_controller.dart';

class OrderDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailsController>(() => OrderDetailsController());
  }
}