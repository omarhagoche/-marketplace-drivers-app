import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/token.dart';
import '../models/user.dart';
import '../services/api/api_service.dart';
ValueNotifier<User> currentUser = new ValueNotifier(User());

class AuthRepository extends ApiService {
  static AuthRepository get instance => AuthRepository();
  final box = Get.find<GetStorage>();

  Future<dynamic?> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    final requestBody = {
      'phone_number': phoneNumber,
      'password': password,
    };
    String? token;
    String? name;
    String? email;
    dynamic responseBody;

    String loginUrl = 'driver/login';

    await post(
      loginUrl,
      data: json.encode(requestBody),
      requireAuthorization: false,
    ).then((response) async {

        print('${response.statusCode}');
        print('${response.data}');
        if (response.statusCode == 200) {
          token = response.data['data']['token'];
          var user = response.data['data']['user'];
          name = user['name'];
          email = user['email'];
          responseBody = response.data['data'];
          if (token != null) {
            //await Token.persistToken(token!);
           await box.write('token', token);
           await box.write('name', name);
           await box.write('email', email);
          }
        } else if (response.statusCode == 422) {
          token = '442';
        }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });
    //
    var boxToken = await box.read('token');
   // print('token $token');
    print('tokennn $boxToken');
    print('tokennn $name');
  //  print('response body $responseBody');
    return responseBody;
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
          setCurrentUser(responseBody);
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
        token = response.data['token'];
        if (token != null) {
          await Token.persistToken(token!);
        }
      }
    });
    print(token);
    return token;
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
