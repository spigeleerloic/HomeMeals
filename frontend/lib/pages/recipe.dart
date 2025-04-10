import 'package:flutter/material.dart';
import 'package:frontend/models/recipe_model.dart';
import 'package:flutter_svg/svg.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipemodel> recipes = [];

  void _get_recipes() {
    recipes = Recipemodel.getRecipes();
  }

  @override
  void initState() {
    _get_recipes();
  }

  @override
  Widget build(BuildContext context) {
    return _recipeContainer();
  }

  Container _recipeContainer() {
    return Container(
      height: 120,
      color: Color(0x7BE68686),
      child: ListView.separated(
        itemCount: recipes.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 20, right: 20),
        separatorBuilder: (context, index) => SizedBox(width: 25),
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            decoration: BoxDecoration(
              color: recipes[index].boxColor,
              borderRadius: BorderRadius.circular(16),
            ),

            child: _recipesSection(index),
          );
        },
      ),
    );
  }

  Column _recipesSection(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(125, 240, 222, 222),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SvgPicture.asset(recipes[index].iconPath),
          ),
        ),
        Text(recipes[index].name),
      ],
    );
  }
}
