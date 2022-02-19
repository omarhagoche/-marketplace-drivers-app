import 'dart:_http';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';
import '../../src/helpers/base.dart';
import '../../src/helpers/custom_trace.dart';
import '../../src/models/credit_card.dart';
import '../../src/models/user.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  final currentUser = Rxn<User?>();

  void login() async {
    if (formKey.currentState != null) {
      formKey.currentState!.save();
      if (formKey.currentState!.validate()) {
        AuthRepository.instance
            .logIn(
          name: nameController.text,
          password: passwordController.text,
        ).then((value) async => goHome());
      }
    }
  }


  void setCurrentUser(jsonString) async {
    try {
      if (json.decode(jsonString)['data'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'current_user', json.encode(json.decode(jsonString)['data']));
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: jsonString).toString());
      throw new Exception(e);
    }
  }
  Future<User?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    //currentUser.value?.auth
    if (currentUser.value?.auth == null && prefs.containsKey('current_user')) {
      var u =User.fromJSON(json.decode(await prefs.getString('current_user')!));
      currentUser.value =
          User.fromJSON(json.decode(await prefs.getString('current_user')!));
      currentUser.value?.auth = true;
    } else {
      currentUser.value?.auth = false;
    }
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentUser.refresh();
    return currentUser.value;
  }


  Future<void> setCreditCard(CreditCard creditCard) async {
    if (creditCard != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('credit_card', json.encode(creditCard.toMap()));
    }
  }


  Future<void> updateDriverAvailable(driverState) async {
    final String _apiToken = 'api_token=${currentUser.value?.apiToken}';
    final String url =
        '${baseURL}api/driver/update-status?$_apiToken';
    final client = new http.Client();
    final response = await client.post(
      Uri.parse(url),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: json.encode({'available': driverState}),
    );
    print("res  " + response.body);
    //return response.body;
  }


  void goHome() {
    Get.offAllNamed(Routes.HOME);
  }
}