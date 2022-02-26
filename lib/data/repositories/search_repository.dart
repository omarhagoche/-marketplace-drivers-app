import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/api/api_service.dart';
class SearchRepository extends ApiService {
  static SearchRepository get instance => SearchRepository();
  final box = Get.find<GetStorage>();
  void setRecentSearch(search) async {
    if (search != null) {
      await box.write('recent_search', search);
    }
  }

  Future<String> getRecentSearch() async {
    String _search = "";
    if (box.hasData('recent_search')) {
      _search = box.read('recent_search').toString();
    }
    return _search;
  }
}