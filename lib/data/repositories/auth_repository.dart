import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/token.dart';
import '../services/api/api_service.dart';

class AuthRepository extends ApiService {
  static AuthRepository get instance => AuthRepository();

  static Future<String?> get token async {
    return await Token.getToken;
  }


  Future<dynamic?> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    final requestBody = {
      'phone_number': phoneNumber,
      'password': password,
    };
    String? token;
    dynamic responseBody;

    String loginUrl = 'driver/login';

    await post(
      loginUrl,
      data: json.encode(requestBody),
      requireAuthorization: false,
    ).then((response) async {

        print('${response.statusCode}');
       // print('${response.data}');
        if (response.statusCode == 200) {
          token = response.data['data']['token'];
          responseBody = response.data['data'];
        /*  if (token != null) {
            await Token.persistToken(token!);
          }*/
        } else if (response.statusCode == 422) {
          token = '442';
        }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });
    //
    print('token $token');
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
       // print('${response.data}');
        if (response.statusCode == 200) {
          responseBody = response.data['data'];
        /*  if (token != null) {
            await Token.persistToken(token!);
          }*/
        } else if (response.statusCode == 422) {
          token = '442';
        }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });
    //
    print('token $token');
  //  print('response body $responseBody');
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



  void setCurrentUser(jsonString) async {
    try {
      if (json.decode(jsonString)['data'] != null) {

      //  SharedPreferences prefs = await SharedPreferences.getInstance();
       /* await prefs.setString(
            'current_user', json.encode(json.decode(jsonString)['data']));*/
      }
    } catch (e) {
      throw new Exception(e);
    }
  }

}
