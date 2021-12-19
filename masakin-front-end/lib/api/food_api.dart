import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:masakin_app/models/food.dart';

class FoodApi {
  static Future<List<Food>> getFoods(String query) async {
    final response =
        await http.get(Uri.https('masakin-rpl.herokuapp.com', 'menu'));
    if (response.statusCode == 200) {
      final List foods = json.decode(response.body);
      return foods.map((json) => Food.fromJson(json)).toList().where((food) {
        final titleLower = food.menuTitle.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
