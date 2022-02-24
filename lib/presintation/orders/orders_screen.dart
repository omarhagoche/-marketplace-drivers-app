

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'orders_controller.dart';


class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final OrdersController controller = Get.put(OrdersController());
    return Obx(
        () => Container(
          child: Center(
            child: Text('Orders.. ${controller.count}'),
          ),
        )
    );



  }
}