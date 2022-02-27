import 'dart:io';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/sabek_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/settings_repository.dart';
import 'loading_widget.dart';
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Get.find<GetStorage>();

    return Drawer(
      child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 0);
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      box.read('name') ?? '',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    accountEmail: Text(
                      currentUser.value.email ?? '',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage:
                          NetworkImage(currentUser.value.image?.thumb ?? ''),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 2);
                  },
                  leading: Icon(
                    SabekIcons.home,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'orders'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 1);
                  },
                  leading: Icon(
                    SabekIcons.messenger,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'messages'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Pages', arguments: 3);
                  },
                  leading: Icon(
                    SabekIcons.list,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                   'history'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  dense: true,
                  title: Text(
                    'application_preferences'.tr,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  trailing: Icon(
                    Icons.remove,
                    color: Theme.of(context).focusColor.withOpacity(0.3),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Help');
                  },
                  leading: Icon(
                    SabekIcons.about,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'help__support'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Settings');
                  },
                  leading: Icon(
                    SabekIcons.settings,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'settings'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Languages');
                  },
                  leading: Icon(
                    SabekIcons.translate,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'languages'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                ListTile(
                  onTap: () {
                    // FirebaseMessaging.instance.getToken().then((_deviceToken) {
                    //   logout(_deviceToken).then((value) {
                    //     Navigator.of(context).pushNamedAndRemoveUntil(
                    //         '/Login', (Route<dynamic> route) => false);
                    //   });
                    // }).catchError((e) {
                    //   print('Notification not configured');
                    // });

                  },
                  leading: Icon(
                    SabekIcons.logout,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'log_out'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              /*  setting.value.enableVersion!
                    ? ListTile(
                        dense: true,
                        title: Text(
                          Platform.isIOS
                              ? 'version'.tr +
                                  " " +
                                  setting.value.appVersionIOS!
                              : 'version'.tr +
                                  " " +
                                  setting.value.appVersionAndroid!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        trailing: Icon(
                          Icons.remove,
                          color: Theme.of(context).focusColor.withOpacity(0.3),
                        ),
                      )
                    : SizedBox(),*/
              ],
            ),
    );
  }
}
