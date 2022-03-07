import 'package:dio/dio.dart';

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
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
          if(dioError.response?.statusCode != null){
            message = Helper.handleError(dioError.response!.statusCode!, 'error');

          }else {
            message = Helper.handleError(0, 'error');
          }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }
}
