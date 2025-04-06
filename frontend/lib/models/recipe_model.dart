import 'package:flutter/material.dart';

class Recipemodel {
  String name;
  String iconPath;
  Color boxColor;

  Recipemodel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<Recipemodel> getRecipes() {
    List<Recipemodel> recipes = [];

    recipes.add(
      Recipemodel(name: "Pizza Funghi", iconPath: 'assets/icons/pizza-svgrepo-com.svg', boxColor: Color.fromARGB(90, 163, 46, 10)),
    );

    recipes.add(
      Recipemodel(name: "Pates bolognaise", iconPath: 'assets/icons/spaghetti-svgrepo-com.svg', boxColor: Color.fromARGB(122, 109, 117, 228)),
    );

    recipes.add(
      Recipemodel(name: "Blanquette de poulet", iconPath: 'assets/icons/drumstick-svgrepo-com.svg', boxColor: Color.fromARGB(121, 214, 48, 139)),
    );
    return recipes;
  }
}
