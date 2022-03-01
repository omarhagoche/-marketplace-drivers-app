import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../../core/utils/helper.dart';
import '../../data/models/order.dart';
import '../../data/models/route_argument.dart';
import 'food_order_item.dart';

class OrderItemWidget extends StatelessWidget {
  final bool? expanded;
  final Order? order;
  final VoidCallback? onTap;
  OrderItemWidget({Key? key, this.expanded, this.order,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
    Opacity(
    opacity: order!.active! ? 1 : 0.4,
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 14),
              padding: EdgeInsets.only(top: 20, bottom: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                ],
              ),
              child: Theme(
                data: theme,
                child: ExpansionTile(
                  initiallyExpanded: expanded!,
                  title: Column(
                    children: <Widget>[
                      Text('${'order_id'.tr}: #${order!.id}'),
                      Text(
                        DateFormat('dd-MM-yyyy | HH:mm').format(order!.dateTime!),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Helper.getPrice(Helper.getTotalOrdersPrice(order: order), context, style: Theme.of(context).textTheme.headline5),
                      Text(
                        'cash_on_delivery'.tr,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  children: <Widget>[
                    Column(
                        children: List.generate(
                      order!.foodOrders!.length,
                      (indexFood) {
                        return FoodOrderItemWidget(heroTag: 'myorders', order: order, foodOrder: order!.foodOrders!.elementAt(indexFood));
                      },
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'subtotal'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1,
                                ),
                              ),
                              Helper.getPrice(
                                  Helper
                                      .getSubTotalOrdersPrice(order:
                                      order),
                                  context,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1)
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'delivery_fee'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1,
                                ),
                              ),
                              Helper.getPrice(
                                  Helper.getDeliveryOrdersPrice(order: order),
                                  context,
                                  style:
                                  Theme.of(context).textTheme.headline4)
                            ],
                          ),
                          order!.restaurantCouponId!=null?
                          rowPrice(price: order!.restaurantCouponValue,context: context)
                          : order!.deliveryCouponId!=null?
                          rowPrice(price: order!.deliveryCouponValue,context: context)
                          :order!.deliveryCouponId!=null&&order!.restaurantCouponId!=null
                              ?rowPrice(price: order!.deliveryCouponValue! + order!.restaurantCouponValue!,context: context)
                              :SizedBox(),

                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'total'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1,
                                ),
                              ),
                              Helper.getPrice(
                                  Helper
                                      .getTotalOrdersPrice(order:
                                      order),
                                  context,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Wrap(
                alignment: WrapAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      //
                      Get.toNamed('ORDER_DETAILS', arguments: {"id":"${order?.id}"});
                      //Navigator.of(context).pushNamed('/OrderDetails', arguments: RouteArgument(id: order!.id));
                    },
                    textColor: Theme.of(context).hintColor,
                    child: Wrap(
                      children: <Widget>[Text('show')],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
    ),
        Container(
          margin: EdgeInsetsDirectional.only(start: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 28,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
    color: order!.active!
    ? Theme.of(context).accentColor
        : Colors.redAccent),
    alignment: AlignmentDirectional.center,
          child: Text(
            order!.active!
                ? '${order!.orderStatus!.status}'
                : 'canceled'.tr,
            maxLines: 1,
            style: Theme.of(context).textTheme.caption!.merge(TextStyle(height: 1, color: Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }
  Widget rowPrice({price,context}){
    return   Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'قيمة الخصم (يتم استعادتها من شركة)',
            style: Theme.of(context)
                .textTheme
                .bodyText1,
          ),
        ),
        Helper.getPrice(
            price,
            context,
            style:
            Theme.of(context).textTheme.headline4)
      ],
    );
  }
}
