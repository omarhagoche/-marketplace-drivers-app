import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../messages/messages_screen.dart';
import '../orders/orders_screen.dart';
import '../orders_history/orders_history_screen.dart';
import '../profile/profile_screen.dart';

class HomeController extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Rxn<Widget> currentScreen = Rxn();
  var currentTab = 0;

  getScreens() {
    return [
      ProfileScreen(),
      MessagesScreen(),
      OrdersScreen(),
      OrdersHistoryScreen(),
    ];
  }

  void selectTab(int tabItem) {

      currentTab = tabItem;
      update();
      print(currentTab);

  }

}