import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';

class OrderHistoryController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> refreshOrdersHistory() async {
    orders.clear();
   // listenForOrdersHistory(message: S.of(state!.context)!.order_refreshed_successfuly);
  }
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  void getOrders() async {
    OrderRepository.instance
        .getOrders().then((value) async {
          orders.value = value;
    });
  }

  Future<void> refreshOrders() async {
    orders.clear();
   // listenForOrders(message: S.of(state!.context)!.order_refreshed_successfuly);
  }

}