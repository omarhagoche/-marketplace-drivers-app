import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) {
  //   if (err.type == DioErrorType.response) {
  //     Helpers.snackbar(err.response!.data['message'].toString());
  //   } else {
  //     super.onError(err, handler);
  //   }
  // }
}
