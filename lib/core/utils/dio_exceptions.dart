import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/utils/helper.dart';

class DioExceptions implements Exception {
  String getError() {
    return message;
  }
  String message = '';

  DioExceptions.fromDioError(DioError dioError) {

    switch (dioError.type) {
      case DioErrorType.cancel:
         message = "Request to API server was cancelled";
         Get.snackbar('حدث خطآ', message);
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        Get.snackbar('حدث خطآ', message);
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        Get.snackbar('حدث خطآ', message);
        break;
      case DioErrorType.response:
          if(dioError.response?.statusCode != null){
            message = Helper.handleError(dioError.response!.statusCode!, 'error');

          }else {
            message = Helper.handleError(0, 'error');
          }
          Get.snackbar('حدث خطآ', message);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        Get.snackbar('حدث خطآ', message);
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }
}
