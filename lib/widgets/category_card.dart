
import 'package:flutter/material.dart';

import '../models/category_model.dart';



class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/categoryDetails", arguments: category);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(
                category.img,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Divider(),
              Text(category.name, style: TextStyle(fontSize: 20)),
              Text(category.desc, style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
