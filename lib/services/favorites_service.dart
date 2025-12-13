import 'package:lab2/models/meal_model.dart';

class FavoritesService {
  FavoritesService._();
  static final FavoritesService instance = FavoritesService._();
  final List<Meal> favorites = [];

  bool isFavorite(String id) {
    for (var meal in favorites) {
      if (meal.id == id) {
        return true;
      }
    }
    return false;
  }

  void addFavorite(Meal meal) {
    if (!isFavorite(meal.id)) {
      favorites.add(meal);
      print("Favorites count: ${favorites.length}");
    }
  }

  void removeFavorite(Meal meal) {
    favorites.removeWhere((m) => m.id == meal.id);
  }
  List<Meal> get favorites_meals => favorites;
}