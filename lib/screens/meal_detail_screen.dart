import 'package:flutter/material.dart';
import 'package:meal/dummy.dart';

class MealDetailScreen extends StatelessWidget {
  //Whenever a new screen opens up it returns a dark screen which occupies entire space .To counter that we need a sccafold
  static const routeName =
      '/meal-detail'; //We write this so that accesing it would be easier
  final Function togglefavourite;
  final Function isfavourite;
  MealDetailScreen(this.togglefavourite, this.isfavourite);
  Widget buildSectiontitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer({Widget child}) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, //For background color
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments
        as String; //Capturing value sent by meal_item

    final selectedMeal = DUMMY_MEALS.firstWhere((meal) =>
        meal.id ==
        mealId); //Returns the first element where the condition is true to be returned

    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        //So that widgets don't go out of the screen
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectiontitle(context, 'Ingredients'),
            buildContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        //Padding inside each elemnet of the ingredients list
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Text(selectedMeal.ingredients[index])),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectiontitle(context, 'Steps'),
            buildContainer(
                //We have selected a meal and we are printing each of the steps
                child: ListView.builder(
              itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(
                  child: Text('# ${index + 1}'),
                ),
                title: Text(selectedMeal.steps[index]),
              ),
              itemCount: selectedMeal
                  .steps.length, //Only single item length which was selected
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isfavourite(mealId)
            ? Icons.star
            : Icons
                .star_border), //Basically isfavourite returns true or false and depending on that i return the right icon
        onPressed: () {
          togglefavourite(mealId);
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          Navigator.of(context)
              .pop(mealId); //pop removes the top item similar as back button
          //I am sending back meal id using this
        },
      ),*/
    );
  }
}
