import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:frontend/models/meals_planning.dart';

class WeeklyPlannerScreen extends StatefulWidget {
  const WeeklyPlannerScreen({super.key});

  @override
  State<WeeklyPlannerScreen> createState() => _WeeklyPlannerScreenState();
}

class _WeeklyPlannerScreenState extends State<WeeklyPlannerScreen> {
  final String currentDay = DateFormat('EEEE').format(DateTime.now());
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

  @override
  void initState() {
    _get_meals_planning();
  }

  void _get_meals_planning() {
    meals = MealsPlanning.getMealsPlanning();
  }

  @override
  Widget build(BuildContext context) {
    return _weeklyPlanningContainer();
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
}
