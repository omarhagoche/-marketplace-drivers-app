import 'package:get/get.dart';
import '../../src/controllers/restaurant_controller.dart';

class RestPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantController>(() => RestaurantController());
  }
}