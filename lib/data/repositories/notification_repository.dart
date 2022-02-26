import 'dart:convert';
import 'dart:io';
import '../services/api/api_service.dart';
import 'auth_repository.dart';
import 'settings_repository.dart';
import '../models/notification.dart';
import '../models/user.dart';
class NotificationRepository extends ApiService {
  static NotificationRepository get instance => NotificationRepository();

  Future<List<Notification>> getNotifications() async {
    User _user = currentUser.value;

    dynamic responseBody;
    final String url = 'notifications';
    await get(
      url,
      queryParameters: {'search':'notifiable_id:${_user.id}',
        'searchFields':'notifiable_id:='
        ,'orderBy':'created_at',
        'sortedBy':'desc',
        'limit':10},
      requireAuthorization: false,
    ).then((response) async {
      print('getNotifications:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Notification>.from(data.map((e) => Notification.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Notification>[];
    });
    return responseBody;
  }
  Future<Notification> markAsReadNotifications(
      Notification notification) async {
    dynamic responseBody;
    final String url = 'notifications/${notification.id}';
       await put(
        url,
          extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
        data: notification.markReadMap(),
      ).then((response) async {
         print('getNotifications:${response.statusCode}');
         if (response.statusCode == 200) {
           final data = response.data['data'] as List;
           responseBody =
               Notification.fromJSON(response.data['data']);}
       }).catchError((onError) async {
         print('error : ${onError} ${onError.toString().isEmpty}');

         responseBody = new Notification();
       });
      return responseBody;
    }

  Future<Notification> removeNotification(Notification notification) async {
    dynamic responseBody;
    final String url = 'notifications/${notification.id}';
       await delete(
           url,
            extraHeaders: {HttpHeaders.contentTypeHeader: 'application/json'},
          ).then((response) async {
         print('removeNotification:${response.statusCode}');
         if (response.statusCode == 200) {
           final data = response.data['data'] as List;
           responseBody =
               Notification.fromJSON(response.data['data']);}
       }).catchError((onError) async {
         print('error : ${onError} ${onError.toString().isEmpty}');

         responseBody = new Notification();
       });
    return responseBody;
  }


  Future<void> sendNotification(String body, String title, User user) async {
     final data = {
       "notification": {"body": "$body", "title": "$title"},
       "priority": "high",
       "data": {
         "click_action": "FLUTTER_NOTIFICATION_CLICK",
         "id": "messages",
         "status": "done"
       },
       "to": "${user.deviceToken}"
     };
     final String url = 'https://fcm.googleapis.com/fcm/send';
     await post(
       url,
       extraHeaders: {
         HttpHeaders.contentTypeHeader: 'application/json',
         HttpHeaders.authorizationHeader: "key=${setting.value.fcmKey}",
       },
       data: json.encode(data),
     ).then((response) async {
       if (response.statusCode != 200) {
         print('notification sending failed');
       }
     });
   }
}



