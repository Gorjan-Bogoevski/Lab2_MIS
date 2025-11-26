class Category {
  String id;
  String name;
  String img;
  String desc;


  Category(this.id, this.name, this.img, this.desc);

  Category.fromJson(Map<String, dynamic> data)
      : id = data['idCategory'],
        name = data['strCategory'],
        img =data['strCategoryThumb'],
        desc = data['strCategoryDescription']
   ;

  Map<String, dynamic> toJson() => {
    'idCategory': id,
    'strCategory': name,
    'strCategoryThumb': img,
    'strCategoryDescription': desc,

  };
}

