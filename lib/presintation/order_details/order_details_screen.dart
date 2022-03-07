import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/helper.dart';
import '../widgets/drawer.dart';
import '../widgets/food_order_item.dart';
import '../widgets/loading_widget.dart';
import 'order_details_controller.dart';

class OrderDetailsScreen extends GetView<OrderDetailsController> {
  const OrderDetailsScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
        init: OrderDetailsController(),
        builder: (_con) => Scaffold(
            key: _con.scaffoldKey,
            drawer: DrawerWidget(),
            bottomNavigationBar: Obx  (()=>_con.order.value == null
                ? Container(
                    height: 193,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.15),
                              offset: Offset(0, -2),
                              blurRadius: 5.0)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                    ),
                  )
                : Container(
                    height: _con.order.value!.orderStatus!.key == 'delivered'
                        ? 190
                        : 250,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.15),
                              offset: Offset(0, -2),
                              blurRadius: 5.0)
                        ]),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'subtotal'.tr,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Helper.getPrice(
                                  Helper.getSubTotalOrdersPrice(
                                      order: _con.order.value),
                                  context,
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'delivery_fee'.tr,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Helper.getPrice(
                                  _con.order.value!.deliveryFee!, context,
                                  style: Theme.of(context).textTheme.subtitle1)
                            ],
                          ),
                          _con.order.value!.restaurantCouponId != null
                              ? rowPrice(
                                  price:
                                      _con.order.value!.restaurantCouponValue,
                                  context: context)
                              : _con.order.value!.deliveryCouponId != null
                                  ? rowPrice(
                                      price:
                                          _con.order.value!.deliveryCouponValue,
                                      context: context)
                                  : _con.order.value!.deliveryCouponId !=
                                              null &&
                                          _con.order.value!
                                                  .restaurantCouponId !=
                                              null
                                      ? rowPrice(
                                          price: _con.order.value!
                                                  .deliveryCouponValue! +
                                              _con.order.value!
                                                  .restaurantCouponValue!,
                                          context: context)
                                      : SizedBox(),
                          Divider(height: 30),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  'total'.tr,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Helper.getPrice(
                                  Helper.getTotalOrdersPrice(
                                      order: _con.order.value),
                                  context,
                                  style: Theme.of(context).textTheme.headline6)
                            ],
                          ),
                          _con.order.value!.canShowButton()
                              ? SizedBox(height: 0)
                              : SizedBox(height: 20),
                          _con.order.value!.canShowButton()
                              ? SizedBox(height: 0)
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: FlatButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                  'delivery_confirmation'.tr),
                                              content: Text(
                                                  'would_you_please_confirm_if_you_have_delivered_all_meals'
                                                      .tr),
                                              actions: <Widget>[
                                                // usually buttons at the bottom of the dialog
                                                FlatButton(
                                                  child: new Text('yes'.tr),
                                                  onPressed: () {
                                                    if (_con.order.value!
                                                            .orderStatus!.key ==
                                                        'driver_assigned') {
                                                      _con
                                                          .order
                                                          .value!
                                                          .orderStatus!
                                                          .id = "45";
                                                      _con.doDeliveredOrder(
                                                          _con.order.value!);
                                                    } else if (_con.order.value!
                                                            .orderStatus!.key ==
                                                        'driver_arrived_restaurant') {
                                                      _con
                                                          .order
                                                          .value!
                                                          .orderStatus!
                                                          .id = "50";
                                                      _con.doDeliveredOrder(
                                                          _con.order.value!);
                                                    } else if (_con.order.value!
                                                            .orderStatus!.key ==
                                                        'driver_pick_up') {
                                                      _con
                                                          .order
                                                          .value!
                                                          .orderStatus!
                                                          .id = "60";
                                                      _con.doDeliveredOrder(
                                                          _con.order.value!);
                                                    } else if (_con.order.value!
                                                            .orderStatus!.key ==
                                                        'on_the_way') {
                                                      _con
                                                          .order
                                                          .value!
                                                          .orderStatus!
                                                          .id = "70";
                                                      _con.doDeliveredOrder(
                                                          _con.order.value!);
                                                    } else if (_con.order.value!
                                                            .orderStatus!.key ==
                                                        'driver_arrived') {
                                                      _con
                                                          .order
                                                          .value!
                                                          .orderStatus!
                                                          .id = "80";
                                                      _con.doDeliveredOrder(
                                                          _con.order.value!);
                                                    }
                                                  },
                                                ),
                                                FlatButton(
                                                  child: new Text('dismiss'.tr),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    color: Theme.of(context).accentColor,
                                    shape: StadiumBorder(),
                                    child: Text(
                                      _con.orderStatus.value ,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  ),
            body: Obx(
              () => _con.order.value == null
                  ? LoadingWidget()
                  : CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        snap: true,
                        floating: true,
                        automaticallyImplyLeading: false,
                        leading: new IconButton(
                          icon: new Icon(Icons.arrow_back,
                              color: Theme.of(context).hintColor),
                          onPressed: () => Get.back(),
                        ),
                        centerTitle: true,
                        title: Text(
                          'order_details'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .merge(TextStyle(letterSpacing: 1.3)),
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        expandedHeight: 230,
                        elevation: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            margin: EdgeInsets.only(top: 95, bottom: 65),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'order_id'.tr +
                                                  ": #${_con.order.value!.id}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            Text(
                                              _con.order.value!.orderStatus!
                                                  .status??'',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Helper.getPrice(
                                              Helper.getTotalOrdersPrice(
                                                  order: _con.order.value),
                                              context,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5),
                                          Text(
                                            'cash_on_delivery'.tr,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          collapseMode: CollapseMode.pin,
                        ),
                        bottom: TabBar(
                            controller: _con.tabController,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.symmetric(horizontal: 10),
                            unselectedLabelColor: Theme.of(context).accentColor,
                            labelColor: Theme.of(context).primaryColor,

                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).accentColor),
                            tabs: [
                              Tab(
                                child: Container(
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.2),
                                          width: 1)),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text('ordered_foods'.tr,style: TextStyle(fontSize: 16),),
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 42,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.2),
                                          width: 1)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('restaurant'.tr,style: TextStyle(fontSize: 16),),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.2),
                                          width: 1)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('customer'.tr,style: TextStyle(fontSize: 16),),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Offstage(
                            offstage: 0 != _con.tabIndex.value,
                            child: ListView.separated(
                              padding: EdgeInsets.only(top: 20, bottom: 50),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: _con.order.value!.foodOrders!.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15);
                              },
                              itemBuilder: (context, index) {
                                return FoodOrderItemWidget(
                                    heroTag: 'my_orders',
                                    order: _con.order.value,
                                    foodOrder: _con.order.value!.foodOrders!
                                        .elementAt(index));
                              },
                            ),
                          ),
                          Offstage(
                            offstage: 1 != _con.tabIndex.value,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'restaurant'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              _con.order.value!.foodOrders![0]
                                                  .food!.restaurant!.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          disabledColor: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.4),
                                          child: Icon(
                                            Icons.store_mall_directory_outlined,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'restaurantAddress'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              _con
                                                      .order
                                                      .value!
                                                      .foodOrders![0]
                                                      .food!
                                                      .restaurant!
                                                      .address ??
                                                  "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          disabledColor: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.4),
                                          onPressed: () {
                                            // Navigator.of(context).pushNamed('/Map', arguments: new RouteArgument(id: '0', param: _con.order));
                                            launch('https://www.google.com/maps/dir/?api=1&destination=' +
                                                _con.order.value!.foodOrders![0]
                                                    .food!.restaurant!.latitude
                                                    .toString() +
                                                ',' +
                                                _con.order.value!.foodOrders![0]
                                                    .food!.restaurant!.longitude
                                                    .toString() +
                                                '&travelmode=driving&dir_action=navigate');
                                          },
                                          child: Icon(
                                            Icons.directions,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'phoneNumber'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              '0${_con.order.value!.foodOrders![0].food!.restaurant!.phone}',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            launch(
                                                "tel:0${_con.order.value!.foodOrders![0].food!.restaurant!.phone}");
                                          },
                                          child: Icon(
                                            Icons.call,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Offstage(
                            offstage: 2 != _con.tabIndex.value,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'fullName'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              _con.order.value!.user!.name ??
                                                  _con
                                                      .order
                                                      .value!
                                                      .unregisteredCustomer!
                                                      .name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          disabledColor: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.4),
                                          onPressed: () {
                                            // Navigator.of(context).pushNamed('/Profile',
                                            //     arguments: new RouteArgument(param: _con.order.deliveryAddress));
                                          },
                                          child: Icon(
                                            Icons.person,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'deliveryAddress'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              _con.order.value!.deliveryAddress!
                                                      .address ??
                                                  _con.order.value!.deliveryAdd!
                                                      .address!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          disabledColor: Theme.of(context)
                                              .focusColor
                                              .withOpacity(0.4),
                                          onPressed: () {
                                            // Navigator.of(context).pushNamed('/Map', arguments: new RouteArgument(id: '0', param: _con.order));
                                            launch('https://www.google.com/maps/dir/?api=1&destination=' +
                                                _con.order.value!
                                                    .deliveryAddress!.latitude
                                                    .toString() +
                                                ',' +
                                                _con.order.value!
                                                    .deliveryAddress!.longitude
                                                    .toString() +
                                                '&travelmode=driving&dir_action=navigate');
                                          },
                                          child: Icon(
                                            Icons.directions,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 7),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'phoneNumber'.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              '0${_con.order.value!.user!.phone}',
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: 42,
                                        height: 42,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            launch(
                                                "tel:0${_con.order.value!.user!.phone}");
                                          },
                                          child: Icon(
                                            Icons.call,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 24,
                                          ),
                                          color: Theme.of(context)
                                              .accentColor
                                              .withOpacity(0.9),
                                          shape: StadiumBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )
                    ]),
            )));
  }

  Widget rowPrice({price, BuildContext? context}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'قيمة الخصم (يتم استعادتها من الشركة)',
            style: Theme.of(context!).textTheme.bodyText1,
          ),
        ),
        Helper.getPrice(price, context,
            style: Theme.of(context).textTheme.headline4)
      ],
    );
  }
}
