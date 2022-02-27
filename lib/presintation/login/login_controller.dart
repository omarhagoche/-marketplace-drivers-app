import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../core/utils/token.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/repositories/faq_repository.dart';
import '../../routes/app_pages.dart';



class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var hidePassword = true.obs;
  final currentUser = Rxn<User?>();

  void passwordToggle(){
    hidePassword.value = !hidePassword.value;
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
        AuthRepository.instance
            .logIn(
          phoneNumber: phoneController.text,
          password: passwordController.text,
        ).then((value) async {
          print("response 44: $value");
          if(value != null) {
            CurrentUser.saveUser(value.toString());
            goHome();
            if(value == 'error') {
            //  goHome();
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