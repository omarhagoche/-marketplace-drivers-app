
import 'package:get/get.dart';

import 'orders_history_controller.dart';


class OrderHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryController>(() => OrderHistoryController());
  }
}