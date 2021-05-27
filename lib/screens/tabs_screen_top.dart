import 'package:flutter/material.dart';
import 'package:meal/screens/categories_screen.dart';
import 'package:meal/screens/favourites_screen.dart';

class TabScreenTop extends StatefulWidget {
  //In this file tabs are displayed in the top like in android studio
  //in flutter for creating tabs we gotta make a whole new screen as such
  //WE DIDNT USE IT IN THIS APP WE USED TAP SCREEN BOTTOM
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreenTop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //initialIndex: 1,//If you want Tab at index 1 to be selected by default.0 is default
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourites',
              ),
            ],
          ),
        ), //TabScreen is a whole new Screen so imagine it like that we gotta define appbar and everything
        body: TabBarView(
          children: <Widget>[
            //The default tab controller automatically links stuff so it  will link bottom and body.Order should match
            CategoriesScreen(),
            // FavouritesScreen()
          ],
        ),
      ),
      length: 2, //No of items in tab
    );
  }
}
