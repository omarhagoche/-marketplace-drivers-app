import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/order.dart';
import '../../data/repositories/order_repository.dart';

class OrderHistoryController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  void getOrders() async {
    OrderRepository.instance
        .getOrdersHistory().then((value) async {
          orders.value = value;
    });
  }
  Future<void> refreshOrdersHistory() async {
    orders.clear();
    getOrders();
  }


}