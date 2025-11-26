import 'package:flutter/material.dart';
import 'package:lab2/screens/home.dart';
import 'package:lab2/screens/categoryDetails.dart';
import 'package:lab2/models/category_model.dart';
import 'package:lab2/screens/recipes.dart';

import 'models/meal_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепти - 221193',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      initialRoute: "/",

      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          );
        }
        if (settings.name == "/categoryDetails") {
          final category = settings.arguments as Category;
          return MaterialPageRoute(
            builder: (context) => CategoryDetailsScreen(category: category),
          );
        }
        if (settings.name == '/recipeDetails') {
          final meal = settings.arguments as Meal;
          return MaterialPageRoute(
            builder: (_) => RecipeDetailsScreen(meal: meal),
          );
        }

        return null;
      },
    );
  }
}