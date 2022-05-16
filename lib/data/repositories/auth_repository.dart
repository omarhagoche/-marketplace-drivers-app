import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/utils/dio_exceptions.dart';
import '../../core/utils/helper.dart';
import '../models/driver_type.dart';
import '../models/user.dart';
import '../services/api/api_service.dart';

ValueNotifier<User> currentUser = new ValueNotifier(User());

class AuthRepository extends ApiService {
  static AuthRepository get instance => AuthRepository();
  final box = Get.find<GetStorage>();

  Future<dynamic> logIn({
    required String phoneNumber,
    required String password,
  }) async {
    final requestBody = {
      'phone_number': phoneNumber,
      'password': password,
    };
    String loginUrl = 'driver/login';
    String? error = '';
    await post(
      loginUrl,
      data: json.encode(requestBody),
    ).then((response) async {
      print('cccc c c ${response.statusCode}');
      print('${response.data}');
      if (response.statusCode == 200) {
        setCurrentUser(response.data['data']['user']);
        currentUser.value = User.fromJSON(response.data['data']['user']);
        // ignore: invalid_use_of_visible_for_testing_member
        // currentUser.notifyListeners();
      } else if (response.statusCode == 422) {
        print('code : ${response.statusCode}');
        error = Helper.handleError(422, '');
      }
    }).catchError((onError) async {
      print('error ::: ${onError.type} ');
      if (onError.toString().contains('422')) {
        if (onError is DioError) {
          final errorMessage = await DioExceptions.fromDioError(onError);
          print(errorMessage);
          print('mess :: :: ${errorMessage.message}');
          error = errorMessage.message;
          print('messages :: ${errorMessage}');
        }
      }
    });

    return error != null ? error : currentUser.value;
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
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';
    });

    print('token $token');
    return responseBody;
  }

  Future<dynamic> signUp({
    required String email,
    required String name,
    required String token,
    required int driverTypeId,
    required String password,
    File? image,
  }) async {
    final requestBody = {
      'token': token,
      'name': name,
      'email': email,
      'password': password,
      'driver_type_id': driverTypeId,
      // 'image': image,
    };

    // String signupUrl = 'driver/register';
    String signupUrl = "https://tests.sabek.ly/api/driver/register";

    String? error;

    await post(
      signupUrl,
      data: json.encode(requestBody),
      // requireAuthorization: false,
    ).then(
      (response) async {
        if (response.statusCode == 200 || response.statusCode == 201) {
          setCurrentUser(response.data['data']);
          currentUser.value = User.fromJSON(response.data['data']);
        } else {
          print('code : ${response.statusCode}');
          error = Helper.handleError(422, '');
        }
      },
    ).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');
    });
    return currentUser.value;
  }

  Future<String?> requestRegister(String phoneNumber) async {
    String url = 'driver/register';
    // String url = "https://tests.sabek.ly/api/driver/register";

    await get(
      url,
      queryParameters: {
        'phone_number': phoneNumber,
      },
    ).then((value) {
      if (value.statusCode == 200) {}
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');
    });
  }

  Future<String> confirmRegisterVerification({
    required String phoneNumber,
    required String otp,
  }) async {
    String url = 'driver/confirm_register';
    // String url = "https://tests.sabek.ly/api/driver/confirm_register";

    final requestBody = {
      'phone_number': phoneNumber,
      'code': otp,
    };

    dynamic responseBody;

    await post(
      url,
      data: json.encode(requestBody),
    ).then((response) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        responseBody = response.data['token'];
      }
    }).catchError((onError) async {
      print('error : ${onError}');
    });

    return responseBody;
  }

  Future<void> logout(deviceToken) async {
    final String url = 'logout';
    await post(url, extraHeaders: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json'
    }, data: {
      'device_token': deviceToken,
    }).then((response) async {
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        currentUser.value = new User();
        await box.remove('current_user');
        await box.remove('token');
      }
    }).catchError((onError) async {
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

  Future<List<DriverType>> getDriverTypes() async {
    late List<DriverType> responseBody;
    //https://test.sabek.app/api/
    final String url = 'driver/driverTypes';

    await get(url).then(
      (response) async {
        if (response.statusCode == 200) {
          responseBody = List.from(response.data['data'])
              .map((type) => DriverType.fromJson(type))
              .toList();
        }
      },
    ).catchError(
      (onError) async {
        print('error : ${onError} ${onError.toString().isEmpty}');

        responseBody = [];
      },
    );

    return responseBody;
  }
}

// Future<Stream<DriverType>> getTypes() async {
//   Uri uri = Helper.getUri('api/driver/driverTypes');
//   print(uri);
//   try {
//     final client = new http.Client();
//     final streamedRest = await client.send(http.Request('get', uri));
//     return streamedRest.stream
//         .transform(utf8.decoder)
//         .transform(json.decoder)
//         .map((data) => Helper.getData(data))
//         .expand((data) => (data as List))
//         .map((data) {
//       return DriverType.fromJson(data);
//     });
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
//     return new Stream.value(new DriverType.fromJson({}));
//   }
// }
