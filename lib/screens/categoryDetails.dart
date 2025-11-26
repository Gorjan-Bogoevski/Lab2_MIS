import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/meal_grid.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Category category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  final ApiService _api = ApiService();

  List<Meal> _allMeals = [];
  List<Meal> _visibleMeals = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  void _loadMeals() async {
    final data = await _api.loadMealList(widget.category.name);
    setState(() {
      _allMeals = data;
      _visibleMeals = data;
      _loading = false;
    });
  }

  void _searchMeals(String text) async {
    text = text.trim();

    if (text.isEmpty) {
      setState(() {
        _visibleMeals = _allMeals;
      });
      return;
    }

    final results = await _api.searchMeals(text);
    final idsInCategory = _allMeals.map((m) => m.id).toSet();
    final filtered = results.where((m) => idsInCategory.contains(m.id)).toList();

    setState(() {
      _visibleMeals = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category.name)),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              onChanged: _searchMeals,
              decoration: InputDecoration(
                hintText: "Пребарај јадење...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: MealGrid(meal: _visibleMeals),
          ),
        ],
      ),
    );
  }
}