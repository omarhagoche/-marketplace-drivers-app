import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/sabek_icons.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller){
        return Scaffold(
          key: controller.scaffoldKey,
         // drawer: DrawerWidget(),
          body: IndexedStack(
            index: controller.currentTab,
            children: controller.getScreens()
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).accentColor,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            iconSize: 22,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
            currentIndex: controller.currentTab,
            onTap: (int i) {
              print(i);
              controller.selectTab(i);
            },
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                  icon: Icon(SabekIcons.user1),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: new Icon(SabekIcons.messenger),
                  label: ''
              ),
              BottomNavigationBarItem(
                  icon: new Icon(SabekIcons.home),
                  label: ''
              ),

              BottomNavigationBarItem(
                  icon: new Icon(SabekIcons.list),
                  label: ''
              ),

            ],
          ),
        );
      },
    );

  }

}