import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/utils/helper.dart';
import '../../data/models/order.dart';
import '../../data/models/order_status.dart';
import '../../data/repositories/order_repository.dart';

class TrackingController extends GetxController {
  final order = Rxn<Order>();
  final orderStatus = <OrderStatus>[].obs;
  GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  void onInit() {
    super.onInit();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }
  void listenForOrder({String? id, String? message}) async {
   try {
     final _order = await OrderRepository.instance.getOrder(id);
     order.value = _order;
   }catch(e){
     print(e.toString());
   }finally{
     listenForOrderStatus();
   }
  }

  void listenForOrderStatus() async {
    try{
    final _orderStatus= await OrderRepository.instance.getOrderStatus();
  orderStatus.assignAll(_orderStatus);
    }catch(e){
  print(e.toString());
  }
}
  List<Step> getTrackingSteps(BuildContext context) {
    List<Step> _orderStatusSteps = [];
    this.orderStatus.forEach((OrderStatus _orderStatus) {
      _orderStatusSteps.add(Step(
        state: StepState.complete,
        title: Text(
          _orderStatus.status!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: order.value!.orderStatus!.id == _orderStatus.id
            ? Text(
          '${DateFormat('HH:mm | yyyy-MM-dd').format(order.value!.dateTime!)}',
          style: Theme.of(context).textTheme.caption,
          overflow: TextOverflow.ellipsis,
        )
            : SizedBox(height: 0),
        content: SizedBox(
            width: double.infinity,
            child: Text(
              '${Helper.skipHtml(order.value!.hint!)}',
            )),
        isActive: (int.tryParse(order.value!.orderStatus!.id!))! >= (int.tryParse(_orderStatus.id!))!,
      ));
    });
    return _orderStatusSteps;
  }

  Future<void> refreshOrder() async {
    order.value = new Order();
    listenForOrder(message: 'tracking_refreshed_successfully');
  }
}
