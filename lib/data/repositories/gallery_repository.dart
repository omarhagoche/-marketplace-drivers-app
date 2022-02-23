import '../models/gallery.dart';
import '../services/api/api_service.dart';
class GalleryRepository extends ApiService {
  static GalleryRepository get instance => GalleryRepository();

  Future<List<Gallery>> getGalleries(String idRestaurant) async {
    dynamic responseBody;
    final String url = 'galleries';
    await get(
      url,
      queryParameters: {'search':'restaurant_id:$idRestaurant'},
      requireAuthorization: false,
    ).then((response) async {
      print('getGalleries:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Gallery>.from(data.map((e) => Gallery.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Gallery>[];
    });
    return responseBody;
  }

}


