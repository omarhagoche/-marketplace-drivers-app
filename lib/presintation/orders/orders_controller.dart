import 'package:get/get.dart';
import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';

class OrdersController extends GetxController {
  var count = 1.obs;
  RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  Future<void> refreshOrders() async {
    getOrders();
  }

  void getOrders() async {
    OrderRepository.instance
        .getOrders().then((value) async {
      orders.value = value;
    });
  }
}