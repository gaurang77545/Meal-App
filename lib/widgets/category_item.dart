import 'package:flutter/material.dart';
import 'package:meal/screens/category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  /*Outputs a single item on the screen for grid View*/
  final String id;

  final String title;

  final Color color; //For background Color

  CategoryItem(this.id, this.title, this.color);

  /*void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //Navigator is a class which is primarily used for navigating stuff as in changing screens and all
      return CategoryMealsScreen(id, title);
    })); //MaterialPageRoute is used for handling animation and stuff like that
    //You automaticaly get a back button on the new page due to flutter

    /*In Flutter multiple pages are managed in a stack .So whenver u open a page it gets added to the stack and u see
    the element located at the top position.When a page is closed it is removed from the stack and the top updates
    */
  }*/
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName, arguments: {
      'id': id,
      'title': title
    }); //We are sending some values using this arguments
    //Also Category Meals is what we used earlier
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //InkWell is a gesture Detector which has a ripple effect when u tap onto it
      onTap: () => selectCategory(context),

      splashColor: Theme.of(context).primaryColor, //The color of ripples

      borderRadius: BorderRadius.circular(
          15), //The border radius here should match that of the container so that the waves remain within it

      child: Container(
        padding: const EdgeInsets.all(15), //Used const to optimize stuff
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        //color:color,
        decoration: BoxDecoration(
          /*BoxDecoration describes how a box should be painted on the screen*/

          gradient: LinearGradient(
              //Using Gradient we are describing the range of colors which will come on the box
              colors: [
                color.withOpacity(0.7),
                color
              ], //We are going from a color with 0.7 opacity to a normal color

              begin: Alignment.topLeft, //Used to provide direction

              end: Alignment
                  .topRight), //We are providing gradient from top Left to Bottom Right
          borderRadius: BorderRadius.circular(15), //To provide circular corners
        ),
      ),
    );
  }
}
