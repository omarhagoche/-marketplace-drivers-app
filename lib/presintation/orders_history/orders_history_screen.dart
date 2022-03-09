import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';
import '../widgets/empty_order.dart';
import '../widgets/order_item.dart';
import 'orders_history_controller.dart';
class OrdersHistoryScreen extends GetView<OrderHistoryController>{
  const OrdersHistoryScreen({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderHistoryController>(
      init: OrderHistoryController(),

        builder: (controller)=> Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => controller.scaffoldKey.currentState!.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'orders_history'.tr,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
          ),

        ),
          drawer: DrawerWidget(),
        body:RefreshIndicator(
            onRefresh: controller.refreshOrdersHistory,
            child: Obx(
                  () => ListView(
                shrinkWrap: true,
                primary: true,
                padding: EdgeInsets.symmetric(vertical: 10),
                children: <Widget>[
                   ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.orders.length,
                    itemBuilder: (context, index) {
                      print(controller.orders.length);
                      var _order = controller.orders.elementAt(index);
                      return OrderItemWidget(expanded: index == 0 ? true : false, order: _order);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                  ),
                ],
              ),
            )

      ),
      ),
    );



  }
}