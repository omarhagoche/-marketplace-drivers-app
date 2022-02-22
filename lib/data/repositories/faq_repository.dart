import '../models/faq_category.dart';
import '../services/api/api_service.dart';
class FaqCategoryRepository extends ApiService {
  static FaqCategoryRepository get instance => FaqCategoryRepository();

  Future<List<FaqCategory>> getFaqCategories() async {
    dynamic responseBody;
    final String url = 'faq_categories';
    await get(
      url,
      queryParameters: {'with':'faqs'},
      requireAuthorization: false,
    ).then((response) async {
      print('faq_categories:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<FaqCategory>.from(data.map((e) => FaqCategory.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <FaqCategory>[];
    });
    return responseBody;
  }

}

