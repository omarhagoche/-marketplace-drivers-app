import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart';
import '../models/order_status.dart';
import '../models/user.dart';
import '../services/api/api_service.dart';
import 'auth_repository.dart';

class OrderRepository extends ApiService {
  static OrderRepository get instance => OrderRepository();

  Future<List<Order>> getOrders() async {
    print('getOrders:}');

    dynamic responseBody;
    final String orderStatusId = "80"; // for delivered status
    User _user = currentUser.value;
    final String url = 'driver/orders';
    await get(
      url,
      queryParameters: {
        'with': 'driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment'
        ,
        'search': 'driver.id:${_user
            .id};order_status_id:$orderStatusId;delivery_address_id:null'
        ,
        'searchFields': 'driver.id:=;order_status_id:<>;delivery_address_id:<>'
        ,
        'searchJoin': 'and'
        ,
        'orderBy': 'id'
        ,
        'sortedBy': 'desc'
      },
      requireAuthorization: true,
    ).then((response) async {
      print('getOrders:${response.data}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Order>.from(data.map((e) => Order.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = <Order>[];
    });
    return responseBody;
  }

  Future<List<Order>> getOrdersHistory() async {
    dynamic responseBody;
    final String orderStatusId = "80"; // for delivered status
    User _user = currentUser.value;
    final String url = 'orders';
    await get(
      url,
      queryParameters: {
        'with': 'driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment'
        ,
        'search': 'driver.id:${_user
            .id};order_status_id:$orderStatusId;delivery_address_id:null'
        ,
        'searchFields': 'driver.id:=;order_status_id:=;delivery_address_id:<>'
        ,
        'searchJoin': 'and'
        ,
        'orderBy': 'id'
        ,
        'sortedBy': 'desc'
      },
      requireAuthorization: true,
    ).then((response) async {
      print('getOrdersHistory:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Order>.from(data.map((e) => Order.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = <Order>[];
    });
    return responseBody;
  }

  Future<Order> getOrder(orderId) async {
    dynamic responseBody;
    final String url = 'orders/$orderId';
    await get(
      url,
      queryParameters: {
        'with': 'user;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment'
      },
      requireAuthorization: true,
    ).then((response) async {
      print('getOrder:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody =
            Order.fromJSON(response.data['data']);
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = new Order();
    });
    return responseBody;
  }

  Future<List<Order>> getOrderWorkOn() async {
    dynamic responseBody;
    final String url = 'orders/open';
    await get(
      url,
      queryParameters: {
        'with': 'user;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment'
      },
      requireAuthorization: true,
    ).then((response) async {
      print('getOrderWorkOn:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Order>.from(data.map((e) => Order.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = <Order>[];
    });
    return responseBody;
  }

  Future<List<Order>> getRecentOrders() async {
    dynamic responseBody;
    User _user = currentUser.value;
    final String url = 'orders';
    await get(
      url,
      queryParameters: {
        'with': 'driver;foodOrders;foodOrders.food;foodOrders.extras;orderStatus;deliveryAddress;payment'
        ,
        'search': 'driver.id:${_user.id};delivery_address_id:null'
        ,
        'searchFields': 'driver.id:=;delivery_address_id:<>'
        ,
        'searchJoin': 'and'
        ,
        'limit': '4'
        ,
        'orderBy': 'id'
        ,
        'sortedBy': 'desc'
      },
      requireAuthorization: true,
    ).then((response) async {
      print('getRecentOrders:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Order>.from(data.map((e) => Order.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = <Order>[];
    });
    return responseBody;
  }

  Future<List<OrderStatus>> getOrderStatus() async {
    dynamic responseBody;
    final String url = 'order_statuses';
    await get(
      url,
      requireAuthorization: true,
    ).then((response) async {
      print('getOrderStatus:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<OrderStatus>.from(data.map((e) => OrderStatus.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = <OrderStatus>[];
    });
    return responseBody;
  }


  Future<bool> deliveredOrder(Order order) async {
    dynamic responseBody;
    final String url = 'orders/${order.id}';
    await put(
        url,
        extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
        data: json.encode(order.deliveredMap()),
        requireAuthorization: true
    ).then((response) async {
      print('deliveredOrder:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody = true;
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = false;
    });
    return responseBody;
  }

  Future<bool> acceptanceOrder(Id) async {
    dynamic responseBody;
    final String url = 'orders/delivery/$Id';
    await post(
        url,
        extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
        requireAuthorization: true

    ).then((response) async {
      print('acceptanceOrder:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody = true;
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = false;
    });
    return responseBody;
  }

  Future<bool> cancelOrder(Id) async {
    dynamic responseBody;
    final String url = 'orders/cancel/$Id';
    await post(
        url,
        extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
        requireAuthorization: true
    ).then((response) async {
      print('acceptanceOrder:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody = true;
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError
          .toString()
          .isEmpty}');

      responseBody = false;
    });
    return responseBody;
  }

  Future<Stream<QuerySnapshot>> getOrderNotification() async {
    return await FirebaseFirestore.instance
        .collection("orders")
        .where('drivers', arrayContains: currentUser.value.id)
        .snapshots();
  }
}

