
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/l10n.dart';
import '../../src/elements/EmptyOrdersWidget.dart';
import '../../src/elements/OrderItemWidget.dart';
import '../../src/elements/ShoppingCartButtonWidget.dart';
import 'orders_history_controller.dart';

class OrdersHistoryScreen extends StatelessWidget{
  const OrdersHistoryScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderHistoryController controller = Get.put(OrderHistoryController());
    return GetBuilder<OrderHistoryController>(
        builder: (controller)
    {
      return Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: (){
                // => widget.parentScaffoldKey!.currentState!.openDrawer(),
              }
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context)!.orders_history,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body:EmptyOrdersWidget() /* RefreshIndicator(
            onRefresh: controller.refreshOrdersHistory,
            child: Obx(
                  () => ListView(
                shrinkWrap: true,
                primary: true,
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
                      return OrderItemWidget(expanded: index == 0 ? true : false, order: _order);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                  ),
                ],
              ),
            )
        ),*/
      );
    });



  }
}