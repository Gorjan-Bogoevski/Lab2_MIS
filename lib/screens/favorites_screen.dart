import 'package:flutter/material.dart';
import 'package:lab2/services/favorites_service.dart';
import 'package:lab2/widgets/meal_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => FavoritesScreenState();
}

class FavoritesScreenState extends State<FavoritesScreen> {
  final fav = FavoritesService.instance;

  @override
  Widget build(BuildContext context) {
    final items = fav.favorites_meals;

    return Scaffold(
      appBar: AppBar(title: const Text("Омилени рецепти")),
      body: items.isEmpty
          ? const Center(child: Text("Немате омилени рецепти."))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => MealCard(meal: items[i]),
      ),
    );
  }
}