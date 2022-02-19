import 'dart:convert';


import 'package:image_picker/image_picker.dart';

import '../../core/utils/token.dart';
import '../services/api/api_service.dart';

class AuthRepository extends ApiService {
  static AuthRepository get instance => AuthRepository();

  static Future<String?> get token async {
    return await Token.getToken;
  }


  Future<String?> logIn({
    required String name,
    required String password,
  }) async {
    final requestBody = {
      'name': name,
      'password': password,
    };
    String? token;

    String loginUrl = '';

    await post(
      loginUrl,
      data: json.encode(requestBody),
      requireAuthorization: false,
    ).then((response) async {
      if (response.statusCode == 200) {
        token = response.data['token'];
        if (token != null) {
          await Token.persistToken(token!);
        }
      }
    });
    return token;
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


}
