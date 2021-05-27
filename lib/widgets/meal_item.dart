import 'package:flutter/material.dart';
import 'package:meal/models/meal.dart';
import 'package:meal/screens/meal_detail_screen.dart';

//We use it when we click on a button to show what would be displayed and the formatting and stuff
class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  //final Function removeItem;
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageURL,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    // @required this.removeItem
  });

  String
      get complexityText //We use it coz Complexity is a enum and we want the string value for it
  {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      //We use then when the page is popped.Result stores the value which is passed back to us
      if (result != null) {
        //  removeItem(result);
      }
    });

    //pushNmaed returns a future argument.Future is excuted in the future .So if our next screen wanna return us something back in the future when we come back to this creen again we use this
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectMeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          //to have circular corners around the rectangle
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              //We create a stack of clip RRect and image and text so they all overlap and below them next items occur
              children: <Widget>[
                ClipRRect(
                  //RRect is used to provide rounded corners to the mage
                  //
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  //Note that we only want rounded corners in top left and right we don't want it in the bottom
                  //The reason is that below that there are elements after which the bottom left and right corners will be available
                  //Also we want rounded corners to overlap with the border radius which was given to the overall Card

                  child: Image.network(
                    //To provide link of image we use Image.network.had the image been stored locally we used Image.asset
                    imageURL,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit
                        .cover, //If the image is not of the size we use this to crop it down to our size and resize it else the
                    //image looks distorted
                  ),
                ),
                Positioned(
                  //attribute of stack which is used to tell where the items are positioned in a particular element in a stack
                  //Imagine surface of element of stack .We are positioning our text there bottom 20 and right 10
                  bottom: 20, //20 px from bottom in the stack it is positioned
                  right: 10,

                  child: Container(
                    width: 300, //So that text doesen't overflow the given width
                    color: Colors.black54, //background color to text
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true, //If text is long it should be wrapped
                      overflow: TextOverflow
                          .fade, //If text is overflowing and looking ugly out of the container it should then just fade out
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceAround, //The 3 elements inside this are given proper space using this
                children: <Widget>[
                  //Each item inside a row is a row here
                  Row(
                    children: <Widget>[
                      Icon(Icons
                          .schedule), //Icons.schedule displays a little clock
                      SizedBox(
                        width: 6,
                      ), //For a little spacing bw logo and text ie clock logo and duration time
                      Text('$duration min')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ), //For a little spacing
                      Text(complexityText)
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 6,
                      ), //For a little spacing
                      Text(affordabilityText)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
