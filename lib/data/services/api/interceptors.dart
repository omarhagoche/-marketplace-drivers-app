import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';

class AppInterceptors extends Interceptor {


  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
       if (err.type == DioErrorType.response) {
          if(err.response?.statusCode == 422) {
            Get.snackbar('error', err.message);
          }else if(err.response?.statusCode == 401){
            Get.snackbar('error', err.message);
            // logout
          }

         // TODO :: handle error better ..
       } else {
         super.onError(err, handler);
      }

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {

    super.onResponse(response, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }
}
