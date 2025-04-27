import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/recipe_model.dart';
import 'package:frontend/models/meals_planning.dart';
import 'package:frontend/pages/recipe.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipemodel> recipes = [];
  List<MealsPlanning> meals = [];
  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  final String currentDay = DateFormat('EEEE').format(DateTime.now());


  final List<Widget> pages = [HomePage(), RecipePage()];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _get_recipes() {
    recipes = Recipemodel.getRecipes();
  }

  void _get_meals_planning() {
    meals = MealsPlanning.getMealsPlanning();
  }

  @override
  void initState() {
    _get_recipes();
    _get_meals_planning();
  }

  @override
  Widget build(BuildContext context) {
    _get_recipes();
    _get_meals_planning();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Recipes"),
            ),
            SizedBox(height: 15),
            _recipeContainer(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Weekly Planning"),
            ),
            SizedBox(height: 15),
            Flexible(
              flex: 2,
              child: _weeklyPlanningContainer()
            )
            
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _weeklyPlanningContainer() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...days.map((day) {
            final mealsForDay = meals.where((m) => m.day == day).toList();
            if (mealsForDay.isEmpty) {
              return Column(
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      color: day == currentDay ? Colors.blue : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 1,
                    child: ListTile(title: Text("No meals planned")),
                  ),
                ],
              );
            }

            return Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: day == currentDay ? Colors.blue : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                ...mealsForDay.map(
                  (meal) => Card(
                    elevation: 2,
                    child: ExpansionTile(
                      title: Text(
                        meal.meal,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(meal.description),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
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

  AppBar appBar() {
    return AppBar(
      title: Text("HomeMeals"),
      backgroundColor: Color(0xFF3BCA72),
      centerTitle: true,
    );
  }
}
