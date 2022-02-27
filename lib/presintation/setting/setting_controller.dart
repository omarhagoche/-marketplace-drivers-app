import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';
class SettingController extends GetxController {
 late GlobalKey<FormState> FormKey;
 late GlobalKey<ScaffoldState> scaffoldKey;
 TextEditingController passwordController = new TextEditingController();
 TextEditingController newPasswordController = new TextEditingController();

 @override
 void onInit() {
   super.onInit();
   FormKey = new GlobalKey<FormState>();
   this.scaffoldKey = new GlobalKey<ScaffoldState>();
 }


  void updateUser(User user) async {
    user.deviceToken = null;
    UserRepository.instance.update(user).then((value) {
     update();
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text('profile_settings_updated_successfully'.tr),
      ));
    });
  }



  void updatePass(User user) async {
    UserRepository.instance.updatePassword(user).then((value) {
      if(value) {
        update();
        scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text('change_password_successfully'.tr),
        ));
      }else scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('the_current_password_error'.tr),
      ));
    });
  }
}
