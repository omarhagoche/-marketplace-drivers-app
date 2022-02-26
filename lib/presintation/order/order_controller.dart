import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/order.dart';
import '../../data/models/route_argument.dart';
import '../../data/repositories/order_repository.dart';

class OrderController extends GetxController {
  List<Order> orders = <Order>[].obs;
  late GlobalKey<ScaffoldState> scaffoldKey;
  Stream<QuerySnapshot>? OrderNoti;

  @override
  void onInit() {
    super.onInit();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  listenForOrderNotification() async {
    OrderRepository.instance.getOrderNotification().then((snapshots) {
      OrderNoti = snapshots;
      update();
    });
  }

  void acceptanceOrderByDriver(id) async {
    OrderRepository.instance.acceptanceOrder(id).then((v) {
      if (v) {
        Get.toNamed('/OrderDetails',
            arguments: RouteArgument(id: id.toString()));
        ScaffoldMessenger.of(scaffoldKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text("لقد قمت باستلام الطلبية"),
        ));
      } else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text("للاسف لقد سابقك احد السائقين في قبول الطلبية"),
        ));
      }
    });
  }

  void cancelOrderByDriver(Order order) async {
    OrderRepository.instance.cancelOrder(order.id).then((v) {
      order.active = false;
      update();
      if (v) {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text("لقد قمت بإلغاء توصيل الطلبية"),
        ));
      } else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text("للاسف لم يتم الغاء توصيل الطلبية"),
        ));
      }
    });
  }

  void listenForOrders() async {
    try {
      final _orders = await OrderRepository.instance.getOrders();
      orders.assignAll(_orders);
    } catch (e) {
      print(e.toString());
    }
  }

  void listenForOrdersHistory() async {
    try {
      final _orders = await OrderRepository.instance.getOrdersHistory();
      orders.assignAll(_orders);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> refreshOrdersHistory() async {
    orders.clear();
    listenForOrdersHistory();
  }

  Future<void> refreshOrders() async {
    orders.clear();
    listenForOrders();
  }
}
