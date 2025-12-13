import 'package:flutter/material.dart';
import 'package:lab2/models/meal_model.dart';
import 'package:lab2/services/favorites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => MealCardState();
}

class MealCardState extends State<MealCard> {
  final FavoritesService fav = FavoritesService.instance;

  @override
  Widget build(BuildContext context) {
    final bool isFav = fav.isFavorite(widget.meal.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/recipeDetails", arguments: widget.meal);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Image.network(
                  widget.meal.img,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.meal.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFav) {
                        fav.removeFavorite(widget.meal);
                      } else {
                        fav.addFavorite(widget.meal);
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}