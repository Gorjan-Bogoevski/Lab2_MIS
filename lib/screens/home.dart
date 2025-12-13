import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();

  List<Category> _all = [];
  List<Category> _filtered = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final data = await _api.loadCategoryList();
    setState(() {
      _all = data;
      _filtered = data;
      _loading = false;
    });
  }

  void search(String text) {
    text = text.toLowerCase();
    setState(() {
      if (text.isEmpty) {
        _filtered = _all;
      } else {
        _filtered = _all.where((c) {
          return c.name.toLowerCase().contains(text) ||
              c.desc.toLowerCase().contains(text);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Категории"),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outlined),
            tooltip: "Рандом рецепт",
            onPressed: () async {
              final randomMeal = await _api.loadRandomRecipe();

              Navigator.pushNamed(
                context,
                "/recipeDetails",
                arguments: randomMeal,
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, "/favorites");
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: search,
              decoration: const InputDecoration(
                hintText: "Пребарај...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: _filtered[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}