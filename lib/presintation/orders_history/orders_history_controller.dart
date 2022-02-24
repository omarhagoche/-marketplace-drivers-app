import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/order.dart';

class OrderHistoryController extends GetxController {
  RxList<Order> orders = <Order>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();


  Future<void> refreshOrdersHistory() async {
    orders.clear();
   // listenForOrdersHistory(message: S.of(state!.context)!.order_refreshed_successfuly);
  }

  Future<void> refreshOrders() async {
    orders.clear();
   // listenForOrders(message: S.of(state!.context)!.order_refreshed_successfuly);
  }

}