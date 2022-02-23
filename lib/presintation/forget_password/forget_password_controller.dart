import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var hidePassword = true.obs;

  void passwordToggle(){
    hidePassword.value = !hidePassword.value;
  }


  void forgetPassword(){
    // TODO : go to forget password
  }
  void signUp(){
    // TODO :: go to sign up
  }



  void resetPassword() async {
    if (passwordController.text.isNotEmpty) {
      AuthRepository.instance
          .resetPassword(
        password: passwordController.text,
      ).then((value) async {
        print("response 44: $value");
        if(value != null) {
          // CurrentUser.saveUser(value.toString());
          // TODO : go to login
          if(value == 'error') {
            ScaffoldMessenger.of(formKey.currentContext!).showSnackBar(SnackBar(
              content: Text('رقم الهاتف او كلمة المرور خاظئ'),
            ));
          }
        }
      });

    }

  }



  void goHome() {
    Get.offAllNamed(Routes.HOME);
  }
}