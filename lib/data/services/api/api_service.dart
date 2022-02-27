import 'dart:async';


import 'package:dio/dio.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/utils/token_injecter.dart';
import '../../../routes/app_pages.dart';
import 'interceptors.dart';

class ApiService {

  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://test.sabek.app/api/',
           // connectTimeout: 10000,
           // receiveTimeout: 15000,
            headers: {
              Headers.contentTypeHeader: Headers.jsonContentType,
              'charset': 'utf-8'
            },
          ),
        )..interceptors.addAll([
    LogInterceptor(request: true, responseBody: true, requestBody: true),
    TokenInjecter()
  ]);

  factory ApiService.getInstance() {
    return ApiService();
  }

  Dio dio;
  final box = Get.find<GetStorage>();

  Options options = Options();

  Future<void> _base(
    String url,
    bool requireAuthorization,
    Map<String, dynamic> extraHeaders,
  ) async {
    Map<String, dynamic>? headers = {};

    headers.addAll(extraHeaders);
    options = Options(headers: headers);
    dio.interceptors.add(AppInterceptors());

    if (requireAuthorization) {
      String? token = await box.read('token');//await Token.getToken;

      if (token != null) {
        options.headers!.addAll({
          'Authorization': 'Bearer $token',
        });
      } else {
        Get.toNamed(Routes.HOME);
      }
    }
  }

  Future<Response> get(
    String url, {
    bool requireAuthorization = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> extraHeaders = const {},
  }) async {
    await _base(url, requireAuthorization, extraHeaders);

    Response response = await dio.get(
      url,
      options: options,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> post(
    String url, {
    dynamic data,
    bool requireAuthorization = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> extraHeaders = const {},
    ProgressCallback? onSendProgress,
  }) async {
    await _base(url, requireAuthorization, extraHeaders);

    Response response = await dio.post(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
    );

    return response;
  }

  Future<Response> put(
    String url, {
    dynamic data,
    bool requireAuthorization = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> extraHeaders = const {},
  }) async {
    await _base(url, requireAuthorization, extraHeaders);

    Response response = await dio.put(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> patch(
    String url, {
    dynamic data,
    bool requireAuthorization = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> extraHeaders = const {},
  }) async {
    await _base(url, requireAuthorization, extraHeaders);

    Response response = await dio.patch(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    bool requireAuthorization = true,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic> extraHeaders = const {},
  }) async {
    await _base(url, requireAuthorization, extraHeaders);

    Response response = await dio.delete(
      url,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
    return response;
  }
}
