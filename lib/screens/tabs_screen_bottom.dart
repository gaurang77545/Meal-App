import 'package:flutter/material.dart';
import 'package:meal/screens/categories_screen.dart';
import 'package:meal/screens/favourites_screen.dart';
import 'package:meal/widgets/main_drawer.dart';
import 'package:meal/models/meal.dart';

class TabScreenBottom extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabScreenBottom(this.favouriteMeals);

  //in flutter for creating tabs we gotta make a whole new screen as such
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreenBottom> {
  //In this the tab bar will be shown on the bottom
  int _selectedPageIndex = 0;
  void _selectIndex(int index) {
    setState(() {
      _selectedPageIndex =
          index; //Fils with the index of the widget which we are selecting
    });
  }

  List<Widget> pages; //We can forward favouriteMeals using this
  @override
  void initState() {
    pages = [
      CategoriesScreen(),
      FavouritesScreen(widget.favouriteMeals)
    ]; //We can't access widget coz we don't use widget when we are initializing properties. stuff above so we use it in initsState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PetPooja'),
      ), //TabScreen is a whole new Screen so imagine it like that we gotta define appbar and everything
      drawer: MainDrawer(),
      body: pages[_selectedPageIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,

        unselectedItemColor:
            Colors.white, //The tab which is not selected will be white in color

        selectedItemColor: Theme.of(context)
            .accentColor, //The tab which is selcted will show this color,

        currentIndex: _selectedPageIndex,

        type: BottomNavigationBarType.shifting, //Too give an animation.Optional

        onTap:_selectIndex, //Flutter automatically fills in the value of the index here
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context)
                  .primaryColor, //We use this in the case of shifting bottom navigation Bar

              icon: Icon(Icons.category),
              title: Text('Categories')),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context)
                  .primaryColor, //We use this in the case of shifting bottom navigation Bar

              icon: Icon(Icons.star),
              title: Text('Favourites'))
        ],
      ),
    );
  }
}
