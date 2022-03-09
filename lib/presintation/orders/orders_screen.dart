

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/drawer.dart';
import '../widgets/empty_order.dart';
import '../widgets/order_item.dart';
import 'orders_controller.dart';


class OrdersScreen extends StatelessWidget {
  final OrdersController controller = Get.put(OrdersController());

/*
  @override
  Widget build(BuildContext context) {
    final OrdersController controller = Get.put(OrdersController());
    return Obx(
        () => Container(
          child: Center(
            child: Text('Orders.. ${controller.count} -- ${controller.orders.length}'),
          ),
        )
    );



  }*/
  @override
  Widget build(BuildContext context) {
    return 12 > 1?
    Scaffold(
      //key: _con.scaffoldKey,
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
          'orders'.tr,
          style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          //new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: controller.refreshOrders,
        child: Obx(
            ()=>ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: <Widget>[
                controller.orders.isEmpty
                    ? EmptyOrdersWidget()
                    : ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    var _order = controller.orders.elementAt(index);
                    return OrderItemWidget(
                      expanded: index == 0 ? true : false,
                      order: _order,
                      onTap: () {
                        //  _con.cancelOrderByDriver(_order);
                        Navigator.of(context).pop();
                      },


                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                ),
              ],
            )
        ),
      ),

    ):
    Scaffold(
      //key: _con.scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
          onPressed: () {}// => _con.scaffoldKey?.currentState?.openDrawer(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'orders'.tr,
          style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: ListView(
        primary: false,
        children: <Widget>[
         // conversationsList(),
        ],
      ),
    );}
}