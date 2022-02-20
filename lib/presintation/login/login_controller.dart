import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/token.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';
import '../../src/helpers/base.dart';
import '../../src/helpers/custom_trace.dart';
import '../../src/models/credit_card.dart';
import '../../src/models/user.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var hidePassword = true.obs;
  final currentUser = Rxn<User?>();

  void passwordToggle(){
    hidePassword.value = !hidePassword.value;
  }


  void forgetPassword(){
    // TODO : go to forget password
  }
  void signUp(){
    // TODO :: go to sign up
  }

  void login() async {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
      if(phoneController.text.startsWith('0')) {
          phoneController.text = phoneController.text.substring(1);
       }
        AuthRepository.instance
            .logIn(
          phoneNumber: phoneController.text,
          password: passwordController.text,
        ).then((value) async {
          print("response 44: $value");
          if(value != null) {
            CurrentUser.saveUser(value.toString());
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