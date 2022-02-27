import '../models/food.dart';
import '../services/api/api_service.dart';
class FoodRepository extends ApiService {
  static FoodRepository get instance => FoodRepository();
  Future<List<Food>> getTrendingFoods() async {
    dynamic responseBody;
    final String url = 'foods';
    await get(
      url,
      queryParameters: {'with':'restaurant','limit':6},
    ).then((response) async {
      print('getTrendingFoods:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Food>.from(data.map((e) => Food.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Food>[];
    });
    return responseBody;
  }

  Future<List<Food>> getFoodsByCategory(categoryId) async {
    dynamic responseBody;
    final String url = 'foods/$categoryId';
    await get(
      url,
      queryParameters: {'with':'restaurant',
    'search':'category_id:$categoryId',
    'searchFields':'category_id:='},
    ).then((response) async {
      print('getFoodsByCategory:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Food>.from(data.map((e) => Food.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Food>[];
    });
    return responseBody;
  }

 Future<Food> getFood(foodId) async {
    dynamic responseBody;
    final String url = 'foods/$foodId';
    await get(
      url,
      queryParameters: {'with':'nutrition;restaurant;category;extras;foodReviews;foodReviews.user',
    },
    ).then((response) async {
      print('getFoodsByCategory:${response.statusCode}');
      if (response.statusCode == 200) {
        responseBody = Food.fromJSON(response.data['data']);
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = new Food();
    });
    return responseBody;
  }
  Future<List<Food>> getFoodsOfRestaurant(String restaurantId) async {
    dynamic responseBody;
    final String url = 'foods';
    await get(
      url,
      queryParameters: {'with':'restaurant',
        'search':'restaurant.id:$restaurantId',
        'searchFields':'restaurant.id:='},
    ).then((response) async {
      print('getFoodsByCategory:${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        responseBody =
        List<Food>.from(data.map((e) => Food.fromJSON(e)));
      }
    }).catchError((onError) async {
      print('error : ${onError} ${onError.toString().isEmpty}');

      responseBody = <Food>[];
    });
    return responseBody;
  }

}





