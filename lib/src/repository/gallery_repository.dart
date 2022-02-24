import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/utils/helper.dart';
import '../../core/values/urls.dart';
import '../../data/models/gallery.dart';
import '../../data/models/user.dart';
import '../repository/user_repository.dart';

Future<Stream<Gallery>> getGalleries(String idRestaurant) async {
  User _user = currentUser.value;
  final String _apiToken = 'api_token=${_user.apiToken}&';
  final String url = '${apiBaseUrl}galleries?${_apiToken}search=restaurant_id:$idRestaurant';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Gallery.fromJSON(data));
}
