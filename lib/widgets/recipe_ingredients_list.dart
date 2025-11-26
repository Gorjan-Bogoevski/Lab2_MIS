import 'package:flutter/material.dart';

class RecipeIngredients extends StatelessWidget {
  final List<String> ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients.map((item) => Text("- $item")).toList(),
    );
  }
}