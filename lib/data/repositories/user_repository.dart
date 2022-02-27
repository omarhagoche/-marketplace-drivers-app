


import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../services/api/api_service.dart';

class UserRepository extends ApiService {
  static UserRepository get instance => UserRepository();
  final box = Get.find<GetStorage>();


  Future<dynamic> userProfile() async {

    dynamic responseBody;
    await get(
      'driver/profile',
      requireAuthorization: true,
    ).then((response) async {

      print('${response.statusCode}');
      print('${response.data}');
      if (response.statusCode == 200) {

        responseBody = response.data['data'];
        // save user data
      } else if (response.statusCode == 422) {
        //token = '442';
      }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });
    //
    var boxToken = await box.read('token');
    // print('token $token');
    print('tokennn $boxToken');
    //  print('response body $responseBody');
    return responseBody;
  }

  Future<dynamic> driverStatistics() async {

    dynamic responseBody;
    await get(
      'driver/statistics',
      requireAuthorization: true,
    ).then((response) async {

      print('${response.statusCode}');
      print('${response.data}');
      if (response.statusCode == 200) {

        responseBody = response.data['data'];
        // save user data
      } else if (response.statusCode == 422) {
        //token = '442';
      }

    }).catchError((onError) async{
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = 'error';

    });
    //
    var boxToken = await box.read('token');
    // print('token $token');
    print('tokennn $boxToken');
    //  print('response body $responseBody');
    return responseBody;
  }


}