import 'package:flutter/material.dart';
import 'package:meal/dummy.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/category_meal_screen.dart';
import 'package:meal/screens/filters_screen..dart';
import 'package:meal/screens/meal_detail_screen.dart';
import 'package:meal/screens/tabs_screen_bottom.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> availableMeals = DUMMY_MEALS; //Meals after applying filters

  List<Meal> favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        //runs on every element meal of dummy_meal
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true; //We can come to this point only if all of the filters which user wants is satisfied.
        //return true means keep that item in the list
      }).toList();
    });
  }

  void _toggleFavourite(String mealid) {
    //To add or remove favourite meal
    final existingIndex =favouriteMeals.indexWhere((meal) => mealid == meal.id);
    if (existingIndex >= 0) {
      //This means the element is already in the favourite meal and we wanna remove it
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealid));
      });
    }
  }

  bool _isFavourite(String id) {
    return favouriteMeals.any((element) =>
        element.id ==
        id); //returns true if any element is there with matching id
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor:
            Color.fromRGBO(255, 254, 229, 1), //Can change color of Sccafold

        fontFamily: 'Raleway',

        textTheme: ThemeData.light().textTheme.copyWith(
              //Copies my settigs which I want to this theme
              //This is my textThem for the whole app
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)), //h1 tag
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)), //h2 tag
              title: TextStyle(
                  fontFamily: 'RoboCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      ),
      //home:CategoriesScreen(), //Widget which should be loaded as the first screen in your app.
      //Note that this widget (pointed by home) should be wrapped up in Sccafold
      //We just use routes because it becomes troublesome to keep track of all the routes

      routes: {
        '/': (ctx) => TabScreenBottom(
            favouriteMeals), //This is the default route works like the home attribute.This screen will open up now
        //Because favourite screen is a part of this we forward it to tab screen.Tab screen then forwards it to favourite screen
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),

        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavourite, _isFavourite),

        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters)
        //I can pass things using this.Advantage of named route
        //You can access static members using classname.member
      }, //You can name the key anything we just name it accordinng to the notation
      //_filters is the cureent filter and _setFilters is the function which we are passing

      onGenerateRoute: (settings) {
        //tells settings of route
        //Most of the time we don't use it.Used for named routes
        //We will go this route if we go to any route which is not registered on our routes attribute before and
        print(settings.arguments);
        /* if(settings.name=='/meal-detail')
        {
          //Do something
        }*/
        return MaterialPageRoute(
            builder: (ctx) =>
                CategoriesScreen() //We will open CatgoriesScreen if we click on any route which is not registered in routes
            );
      },
      onUnknownRoute: (settings) {
        //Used when no route is working then we use it.Kind of like a page not found error 404
        //We can crate an error page and display that
        //Used when on GenerateRoute isn't defined
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
