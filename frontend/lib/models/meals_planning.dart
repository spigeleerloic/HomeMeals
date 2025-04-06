class MealsPlanning {
  String day;
  String meal;
  String description;

  MealsPlanning({
    required this.day,
    required this.meal,
    required this.description,
  });

  static List<MealsPlanning> getMealsPlanning() {
    return [
      MealsPlanning(day: 'Monday', meal: 'Spaghetti Bolognese', description: 'With garlic bread and salad'),
      MealsPlanning(day: 'Monday', meal: 'Grilled Chicken', description: 'Served with rice and veggies'),
      MealsPlanning(day: 'Tuesday', meal: 'Fish Tacos', description: 'With lime and avocado sauce'),
      MealsPlanning(day: 'Wednesday', meal: 'Veggie Stir Fry', description: 'Soy sauce and tofu'),
      //MealsPlanning(day: 'Thursday', meal: 'Beef Stew', description: 'With potatoes and carrots'),
      MealsPlanning(day: 'Friday', meal: 'Pizza Night', description: 'Homemade pepperoni and cheese'),
      MealsPlanning(day: 'Saturday', meal: 'Burgers', description: 'With fries and coleslaw'),
      MealsPlanning(day: 'Sunday', meal: 'Roast Chicken', description: 'Classic Sunday roast with gravy'),
    ];

  }
}
