import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/helper.dart';
import '../../data/repositories/auth_repository.dart';
import '../widgets/profile_settings.dart';
import 'setting_controller.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
        init: SettingController(),
        initState: (_) {},
        builder: (_con) => Scaffold(
              key: _con.scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  'settings'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .merge(TextStyle(letterSpacing: 1.3)),
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  currentUser.value.name??'',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                Text(
                                  currentUser.value.email!,
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                              width: 55,
                              height: 55,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(300),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/Pages', arguments: 0);
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      currentUser.value.image!.thumb!),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              'profile_settings'.tr,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            trailing: ButtonTheme(
                              padding: EdgeInsets.all(0),
                              minWidth: 50.0,
                              height: 25.0,
                              child: ProfileSettingsDialog(
                                user: currentUser.value,
                                onChanged: () {
                                  _con.updateUser(currentUser.value);
                                  //setState(() {});
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              'full_name'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            trailing: Text(
                              currentUser.value.name!,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              'email'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            trailing: Text(
                              currentUser.value.email!,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              'phone'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            trailing: Text(
                              currentUser.value.phone!,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              'address'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            trailing: Text(
                              Helper.limitString(currentUser.value.address??''),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            dense: true,
                            title: Text(
                              'about'.tr,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            trailing: Text(
                              Helper.limitString(currentUser.value.bio!),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Theme.of(context).focusColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.15),
                              offset: Offset(0, 3),
                              blurRadius: 10)
                        ],
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.settings),
                            title: Text(
                              'app_settings'.tr,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // return object of type Dialog
                                  return AlertDialog(
                                    title: new Text('change_password'.tr),
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [
                                          TextField(
                                            obscureText: true,
                                            controller: _con.passwordController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'ادخل كلمة المرور الحاليا ',
                                            ),
                                          ),
                                          TextField(
                                            obscureText: true,
                                            controller:
                                                _con.newPasswordController,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'ادخل كلمة المرور الجديدة ',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      Row(
                                        children: <Widget>[
                                          new FlatButton(
                                            child: new Text("الغاء"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          new FlatButton(
                                            onPressed: () {
                                              currentUser.value.password =   _con.passwordController.text;
                                              currentUser.value.newPassword =_con.newPasswordController.text;
                                              _con.updatePass(currentUser.value);
                                              Get.back();
                                              _con.passwordController.clear();
                                              _con.newPasswordController
                                                  .clear();
                                            },
                                            child: new Text("حفظ"),
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            dense: true,
                            title: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.lock,
                                  size: 22,
                                  color: Theme.of(context).focusColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'change_password'.tr,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.toNamed('/LANGUAGE');
                            },
                            dense: true,
                            title: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.translate,
                                  size: 22,
                                  color: Theme.of(context).focusColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'languages'.tr,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                            // trailing: Text(
                            //   S.of(context).english,
                            //   style: TextStyle(color: Theme.of(context).focusColor),
                            // ),
                          ),
                          ListTile(
                            onTap: () {
                              Get.toNamed('/HELP');
                            },
                            dense: true,
                            title: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.help,
                                  size: 22,
                                  color: Theme.of(context).focusColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'help_support'.tr,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
