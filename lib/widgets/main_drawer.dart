import 'package:flutter/material.dart';
import 'package:meal/screens/filters_screen..dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      //List Tile has an onpressed argument
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            //If you are using decoration here then set color using that else there will be an error in flutter
            child: Text(
              'Cooking Up',
              style: TextStyle(
                  fontWeight: FontWeight.w900, //Sets the font weight to 900
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/'); //Default Route
              //PushNamed keeps on adding things to the stack so by using it we would always get a back button.However popping only happens when we click back button
              //If we use pushNamedReplace then we won't get back button coz it replaces the top item
            },
          ),
          buildListTile('Filters', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          })
        ],
      ),
    );
  }
}
