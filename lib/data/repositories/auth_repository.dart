import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user.dart';
import '../services/api/api_service.dart';
ValueNotifier<User> currentUser = new ValueNotifier(User());

class AuthRepository extends ApiService {
  static AuthRepository get instance => AuthRepository();
  final box = Get.find<GetStorage>();

  Future<User> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    final requestBody = {
      'phone_number': phoneNumber,
      'password': password,
    };
    String loginUrl = 'driver/login';

    await post(
      loginUrl,
      data: json.encode(requestBody),
    ).then((response) async {

        print('${response.statusCode}');
        print('${response.data}');
        if (response.statusCode == 200) {
          setCurrentUser(response.data['data']['user']);
          currentUser.value=User.fromJSON(response.data['data']['user']);
          // ignore: invalid_use_of_visible_for_testing_member
         // currentUser.notifyListeners();
        } else if (response.statusCode == 422) {
          print(response.statusCode);
        }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

    });

    return currentUser.value;
  }


  Future<dynamic?> resetPassword({
    required String password,
  }) async {
    final requestBody = {
      'password': password,
    };
    String? token;
    dynamic responseBody;

    String loginUrl = 'reset_password';

    await post(
      loginUrl,
      data: json.encode(requestBody),
      requireAuthorization: false,
    ).then((response) async {
        print('${response.statusCode}');
        print('${response.data}');
        if (response.statusCode == 200) {
          responseBody = response.data['data'];
        } else if (response.statusCode == 422) {
          token = '442';
        }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });

    print('token $token');
    return responseBody;
  }

  Future<String?> signUp({
    required String phoneNumber,
    required String password,
  }) async {
    final requestBody = {
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': password,
    };
    String? token;

    String signupUrl = '';


    await post(
      signupUrl,
      data: json.encode(requestBody),
      requireAuthorization: false,
    ).then((response) async {
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);

      }
    });
    print(token);
    return token;
  }
  Future<void> logout(deviceToken) async {
    final String url =
        'logout';
    await post(
        url,
        extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json'},
        data: {
          'device_token': deviceToken,
        }
    ).then((response) async {
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        currentUser.value = new User();
        await box.remove('current_user');
        await box.remove('token');
      }
    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');
    });
  }



  void setCurrentUser(user) async {
    if (user != null) {
      await box.write('current_user', user);
    }
  }


  Future<User> getCurrentUser() async {
    if (box.hasData('current_user'))
      currentUser.value = User.fromJSON(box.read('current_user'));
    return currentUser.value;
  }
}
