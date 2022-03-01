import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/order.dart';
import '../../data/models/route_argument.dart';
import '../../data/repositories/order_repository.dart';

class OrderDetailsController extends GetxController with GetTickerProviderStateMixin {
  final order = Rxn<Order>();
  late GlobalKey<ScaffoldState> scaffoldKey;
  final orderStatus =''.obs;
  TabController? tabController;
  final tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForOrder(id: Get.arguments['id']);
    tabController =
        TabController(length: 3, initialIndex: tabIndex.value, vsync: this);
    tabController!.addListener(_handleTabSelection);

  }

  _handleTabSelection() {
    if (tabController!.indexIsChanging) {

        tabIndex.value = tabController!.index;
      }

  }

  void acceptanceOrderByDriver(id) async {
    ///Todo loading
    OrderRepository.instance.acceptanceOrder(id).then((v) {
      if(v) {
        Get.toNamed('/OrderDetails', arguments: RouteArgument(id: id.toString()));
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text("لقد قمت باستلام الطلبية"),
        ));
      }else {
        ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
          content: Text("للاسف لقد سابقك احد السائقين في قبول الطلبية"),
        ));}
    });
  }
  void listenForOrder({String? id, String? message}) async {
    final _order = await OrderRepository.instance.getOrder(id);
        order.value = _order;
        if(order.value!.orderStatus!.id == '40')
          orderStatus.value='driver_arrived_restaurant'.tr;
        else if(order.value!.orderStatus!.id == '45')
          orderStatus.value='driver_pick_up'.tr;
        else if(order.value!.orderStatus!.id == '50')
          orderStatus.value='on_the_way'.tr;
        else if(order.value!.orderStatus!.id == '60')
          orderStatus.value='driver_arrived'.tr;
        else if(order.value!.orderStatus!.id == '70')
          orderStatus.value='delivered'.tr;
      }


  Future<void> refreshOrder() async {
    listenForOrder(id: order.value!.id, message: 'order_refreshed_successfuly');
  }

  void doDeliveredOrder(Order _order) async {
    ///Todo loading
    OrderRepository.instance.deliveredOrder(_order).then((value) {
        order.value!.orderStatus!.id = _order.orderStatus!.id;
        _order.orderStatus!.id ==
            '50'
            ? orderStatus.value='on_the_way'.tr
            : _order.orderStatus!.id ==
            '60'
            ? orderStatus.value='driver_arrived'.tr
            : _order.orderStatus!.id ==
            '70'
            ? orderStatus.value='delivered'.tr
            : orderStatus.value='driver_pick_up'.tr;

      if(value) {
        listenForOrder(id: _order.id);
        if(_order.orderStatus!.id=="80"){
          Get.offAllNamed(
              "/Pages", arguments: 3);
          ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
            content: Text('تم تسليم الطلب بنجاح إلى العميل'),
          ));
        }else  Get.back();
      }
    });
  }
}
