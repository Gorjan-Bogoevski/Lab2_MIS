class Meal {
  String id;
  String name;
  String img;



  Meal(this.id, this.name, this.img);

  Meal.fromJson(Map<String, dynamic> data)
      : id = data['idMeal'],
        name = data['strMeal'],
        img =data['strMealThumb']
  ;

  Map<String, dynamic> toJson() => {
    'idMeal': id,
    'strMeal': name,
    'strMealThumb': img

  };
}

