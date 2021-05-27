import 'package:flutter/material.dart';
import 'package:meal/widgets/meal_item.dart';
import 'package:meal/models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  //The screen which opens up after click on a grid view;

  static const routeName = './category-meals';

  final List<Meal> availableMeal;

  CategoryMealsScreen(this.availableMeal);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;

  List<Meal> displayedMeals; //Meals for that respective Categories

  bool _loadedinitData = false;
  @override
  void initState() {
    //Using void initState coz it will load data the first time the widget loads onto screen
    //However context doesent work in init State so we use something else
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //We use it coz this thing still runs before build and context also works here

    if (!_loadedinitData) {
      //didChanged Dependencies Runs whenever dependencies changes so it runs many times unike initState which only runs one time.So even if we delete an item all the items are loaded again
      //So we only have to make it run one time only and hence we use the condition check
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      //We are storing the values which we got from category item here ie what category we stored
      //We tell flutter that the values recived will be of string keys +value

      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];

      displayedMeals = widget.availableMeal.where((meals) {
        //We are going throught the DUMMY_MEALS and taking only those i/p where certain thing is true
        //  We are going through the available meals ie meals we get after applying a filter
        return meals.categories.contains(
            categoryId); //Basically we are selecting a specific category only and the cond is given using where
      }).toList();
      _loadedinitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeals(String id) {
    setState(() {
      displayedMeals.removeWhere((meal) =>
          meal.id ==
          id); //Goes through the list and removes items where cond is true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        //ListView.builder makes sure that the items that are not on the screen are not rendered and ensures better performance than only listview
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageURL: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            //  removeItem: removeMeals,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
