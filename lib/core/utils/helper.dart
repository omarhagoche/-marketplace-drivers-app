import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import '../../data/models/food_order.dart';
import '../../data/models/order.dart';
import '../../data/repositories/settings_repository.dart';
import 'package:get/get.dart';
class Helper {
  BuildContext? context;
  DateTime? currentBackPressTime;
  Helper.of(BuildContext _context) {
    this.context = _context;
  }




  static String handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 422:
        return 'خطآ في البيانات المدخلة';
      case 404:
        return error["message"];
      case 401:
        return 'Unauthenticated';
      case 500:
        return 'Internal server error';
      default:
        return 'something went wrong';
    }
  }

  static Widget getPrice(double myPrice, BuildContext context, {TextStyle? style}) {
    if (style != null) {
      style = style.merge(TextStyle(fontSize: style.fontSize! + 2));
    }
    try {
      if (myPrice == 0) {
        return Text('-', style: style ?? Theme.of(context).textTheme.subtitle1);
      }
      return RichText(
        softWrap: false,
        overflow: TextOverflow.fade,
        maxLines: 1,
        text: setting.value.currencyRight != null && setting.value.currencyRight == false
            ? TextSpan(
                text: setting.value.defaultCurrency,
                style: style ?? Theme.of(context).textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(text: myPrice.toStringAsFixed(2) , style: style ?? Theme.of(context).textTheme.subtitle1),
                ],
              )
            : TextSpan(
                text: myPrice.toStringAsFixed(2),
                style: style ?? Theme.of(context).textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(
                      text: setting.value.defaultCurrency,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: style != null ? style.fontSize! - 4 : Theme.of(context).textTheme.subtitle1!.fontSize! - 4)),
                ],
              ),
      );
    } catch (e) {
      return Text('');
    }
  }

  static double getTotalOrderPrice(FoodOrder foodOrder) {
    double total = foodOrder.price!;
    foodOrder.extras!.forEach((extra) {
      total += extra.price! != null ? extra.price! : 0;
    });
    total *= foodOrder.quantity!;
    return total;
  }

  static double getOrderPrice({FoodOrder? foodOrder}) {
    double total = foodOrder!.price!;
    foodOrder.extras!.forEach((extra) {
      total += extra.price! != null ? extra.price! : 0;
    });
    return total;
  }

  static double getTaxOrder(Order order) {
    double total = 0;
    order.foodOrders!.forEach((foodOrder) {
      total += getTotalOrderPrice(foodOrder);
    });
    total += order.deliveryFee!;
    return order.tax! * total / 100;
  }

  static String skipHtml(String htmlString) {
    try {
      var document = parse(htmlString);
      String parsedString = parse(document.body!.text).documentElement!.text;
      return parsedString;
    } catch (e) {
      return '';
    }
  }

  static double getSubTotalOrdersPrice({Order? order}) {
    double subtotal = 0;
    order!.foodOrders!.forEach((foodOrder) {
      subtotal += getTotalOrderPrice(foodOrder);
    });
    if(order.restaurantCouponValue!=0.0&&order.restaurantCouponValue!=null)
      subtotal -= order.restaurantCouponValue!;
    return subtotal;
  }

  static double getDeliveryOrdersPrice({Order? order}) {
    double deliveryFee = 0;
    if(order!.deliveryCouponValue!=0.0&&order.deliveryCouponValue!=null){
      deliveryFee= order.deliveryFee!-order.deliveryCouponValue!;
      return deliveryFee;
    }else return order.deliveryFee!;
  }
  static double getTotalOrdersPrice({Order? order}) {
    double total = 0;
    order!.foodOrders!.forEach((foodOrder) {
      total += getTotalOrderPrice(foodOrder);
    });
    total += order.deliveryFee!;
    total += order.tax! * total / 100;
    if(order.restaurantCouponValue!=0.0&&order.restaurantCouponValue!=null)
      total -= order.restaurantCouponValue!;
    if(order.deliveryCouponValue!=0.0&&order.deliveryCouponValue!=null)
      total -= order.deliveryCouponValue!;
    return total;
  }


  static String limitString(String? text, {int limit = 24, String hiddenText = "..."}) {
    return text!.substring(0, min<int>(limit, text.length)) + (text.length > limit ? hiddenText : '');
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'tapAgainToLeave'.tr);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
  String trans(String text) {
    switch (text) {
      case "App\\Notifications\\StatusChangedOrder":
        return 'order_satatus_changed'.tr;
      case "App\\Notifications\\NewOrder":
        return 'new_order_from_costumer'.tr;
      case "App\\Notifications\\AssignedOrder":
        return 'your_have_an_order_assigned_to_you'.tr;
      case "km":
        return 'km'.tr;
      case "mi":
        return 'mi'.tr;
      case "total_earning_after":
        return 'totalEarningAfter'.tr;
        case "total_earning_before":
        return 'totalEarningBefore'.tr;
      case "total_orders":
        return 'totalOrders'.tr;
        case "company_ratio":
        return 'company_ratio'.tr;
        case "coupons":
        return 'coupons'.tr;
      default:
        return "";
    }
  }
}
