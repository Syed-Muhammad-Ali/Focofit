import 'package:flutter/material.dart';
import 'package:focofit/views/pages/receipes/components/receipes_card.dart';

class AllReceipesPage extends StatefulWidget {
  const AllReceipesPage({super.key});

  @override
  State<AllReceipesPage> createState() => _AllReceipesPageState();
}

class _AllReceipesPageState extends State<AllReceipesPage> {
  final List<Map<String, String>> demoRecipes = List.generate(
    6,
    (index) => {
      "title": "Smoked salmon with lemon sauce and chestnut sauce",
      "time": "10 min",
      "kcal": "319 kcal",
      "image":
          "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500",
    },
  );
  @override
  Widget build(BuildContext context) {
    return _buildGrid(demoRecipes);
  }

  Widget _buildGrid(List recipes) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: recipes[index]);
      },
    );
  }
}
