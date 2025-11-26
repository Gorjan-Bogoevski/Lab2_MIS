class Recipe {
  final String id;
  final String? ytLink;
  final String instructions;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.ytLink,
    required this.instructions,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> data) {
    List<String> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i'];
      final measure = data['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty) {
        String ingr = ingredient.toString().trim();
        String meas = measure?.toString().trim() ?? "";

        if (meas.isNotEmpty) {
          ingredientsList.add("$meas $ingr");
        } else {
          ingredientsList.add(ingr);
        }
      }
    }

    return Recipe(
      id: data['idMeal'],
      ytLink: (data['strYoutube'] as String?)?.trim().isEmpty ?? true
          ? null
          : data['strYoutube'],
      instructions: data['strInstructions'] ?? "",
      ingredients: ingredientsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strYoutube': ytLink,
    'strInstructions': instructions,
    'ingredients': ingredients,
  };
}