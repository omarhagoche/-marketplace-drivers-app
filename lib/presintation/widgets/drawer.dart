import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/utils/sabek_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Get.find<GetStorage>();

    return Drawer(
      child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.HOME,);
                  },
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      currentUser.value.name ?? '',
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
                    Get.toNamed(Routes.NOTIFICATION);
                  },
                  leading: Icon(
                    SabekIcons.bell1,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'notification'.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),

                ListTile(
                  onTap: () {
                   Get.toNamed(Routes.HELP);
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
                    Get.toNamed(Routes.SETTING);
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
                    Get.toNamed(Routes.LANGUAGE);
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
                    FirebaseMessaging.instance.getToken().then((_deviceToken) {
                      AuthRepository.instance.logout(_deviceToken).then((value) {
                        Get.offAndToNamed(Routes.LOGIN);
                      });
                    }).catchError((e) {
                      print('Notification not configured');
                    });

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
