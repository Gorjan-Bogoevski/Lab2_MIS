import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';
import '../models/recipe_model.dart';

class ApiService {

  Future<List<Category>> loadCategoryList() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load categories");
    }

    final data = json.decode(response.body);

    return (data['categories'] as List)
        .map((item) => Category.fromJson(item))
        .toList();
  }


  Future<List<Meal>> loadMealList(String category) async {
    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=${Uri.encodeComponent(category)}',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load meals");
    }

    final data = json.decode(response.body);

    if (data['meals'] == null) {
      return [];
    }

    return (data['meals'] as List)
        .map((item) => Meal.fromJson(item))
        .toList();
  }

  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=${Uri.encodeComponent(query)}',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to search meals");
    }

    final data = json.decode(response.body);

    if (data['meals'] == null) {
      return [];
    }

    return (data['meals'] as List)
        .map((item) => Meal.fromJson(item))
        .toList();
  }

  Future<Recipe> loadRecipe(String id) async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load recipe");
    }

    final data = json.decode(response.body);

    final meal = data['meals'][0];
    return Recipe.fromJson(meal);
  }

  Future<Meal> loadRandomRecipe() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to load random recipe");
    }

    final data = json.decode(response.body);
    final meal = data['meals'][0];

    return Meal.fromJson(meal);
  }
}