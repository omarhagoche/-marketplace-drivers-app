import '../models/category.dart';
import '../services/api/api_service.dart';

class CategoryRepository extends ApiService {
  static CategoryRepository get instance => CategoryRepository();

  Future<List<Category>> getCategories() async {
    dynamic responseBody;
    final String url = 'categories';
    await get(
      url,
      requireAuthorization: false,
    ).then((response) async {
      print('categories:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
            List<Category>.from(data.map((e) => Category.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Category>[];
    });
    return responseBody;
  }

  Future<Category> getCategory(String id) async {
    dynamic responseBody;
    final String url = 'categories/$id';

    await get(
      url,
      requireAuthorization: false,
    ).then((response) async {
      print('category:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody = Category.fromJSON(response.data['data']);
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = new Category();
    });
    return responseBody;
  }
}
