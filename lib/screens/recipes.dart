import 'package:flutter/material.dart';

import '../models/meal_model.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';
import '../widgets/recipe_ingredients_list.dart';
import '../widgets/recipe_instructions.dart';
import '../widgets/recipe_youtube_button.dart';


class RecipeDetailsScreen extends StatefulWidget {
  final Meal meal;

  const RecipeDetailsScreen({super.key, required this.meal});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  final ApiService _api = ApiService();
  late Future<Recipe> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.loadRecipe(widget.meal.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.meal.name)),
      body: FutureBuilder<Recipe>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final recipe = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(widget.meal.img),

                const SizedBox(height: 10),

                Text(
                  widget.meal.name,
                  style: const TextStyle(fontSize: 22),
                ),

                const SizedBox(height: 15),

                RecipeIngredients(ingredients: recipe.ingredients),

                const SizedBox(height: 15),

                RecipeInstructions(instructions: recipe.instructions),

                const SizedBox(height: 15),

                RecipeYoutubeLink(url: recipe.ytLink),
              ],
            ),
          );
        },
      ),
    );
  }
}