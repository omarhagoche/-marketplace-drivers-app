import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';



class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var hidePassword = true.obs;
  final currentUser = Rxn<User?>();
  var loading = false.obs;
  var error = ''.obs;
  void passwordToggle(){
    hidePassword.value = !hidePassword.value;
  }

  void forgetPassword(){
    Get.toNamed(Routes.FORGET_PASSWORD);
  }
  void signUp(){
    Get.toNamed(Routes.SIGNUP);
  }

  void login() async {
    if (phoneController.text.isNotEmpty && passwordController.text.isNotEmpty ) {
      if(phoneController.text.startsWith('0')) {
          phoneController.text = phoneController.text.substring(1);
       }
        loading.value = true;
        error.value = '';
        AuthRepository.instance
            .logIn(
          phoneNumber: phoneController.text,
          password: passwordController.text,
        ).then((value) async {
          if(value is User) {
            if(value.id!=null)goHome();
          }
          error.value = value;
          print("response data : $value");
          loading.value = false;


        });

    }
  }



  void goHome() {
    Get.offAllNamed(Routes.HOME);
  }
}