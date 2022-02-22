import 'package:shared_preferences/shared_preferences.dart';

import '../services/api/api_service.dart';
class SearchRepository extends ApiService {
  static SearchRepository get instance => SearchRepository();

  void setRecentSearch(search) async {
    if (search != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('recent_search', search);
    }
  }

  Future<String> getRecentSearch() async {
    String _search = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('recent_search')) {
      _search = prefs.get('recent_search').toString();
    }
    return _search;
  }
}