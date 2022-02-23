import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SettingController extends GetxController {
 late GlobalKey<FormState> FormKey;
 late GlobalKey<ScaffoldState> scaffoldKey;
 @override
 void onInit() {
   super.onInit();
   FormKey = new GlobalKey<FormState>();
   this.scaffoldKey = new GlobalKey<ScaffoldState>();
 }


  // void updateUser(User user) async {
  //   user.deviceToken = null;
  //   repository.update(user).then((value) {
  //     setState(() {
  //       //this.favorite = value;
  //     });
  //     ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
  //       content: Text(S.of(state!.context)!.profile_settings_updated_successfully),
  //     ));
  //   });
  // }



  // void updatePass(User user) async {
  //   repository.updatePassword(user).then((value) {
  //     if(value) {
  //       setState(() {});
  //       scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //         content: Text(S
  //             .of(state!.context)
  //         !.change_password_successfully),
  //       ));
  //     }else scaffoldKey?.currentState?.showSnackBar(SnackBar(
  //       content: Text(S
  //           .of(state!.context)
  //       !.the_current_password_error),
  //     ));
  //   });
  // }
}
