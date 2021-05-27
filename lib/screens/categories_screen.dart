import 'package:flutter/material.dart';
import 'package:meal/widgets/category_item.dart';
import '../dummy.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      //We don't add a sccafold here in case of tab screen so that 2 appbars aren't shown here.Coz tab screen controls entire screen and not the categories screen

      padding: const EdgeInsets.all(
          25), //Adding a const makes sure that this thing doesent get rebuild again when the app reloads

      children: DUMMY_CATEGORIES
          .map((catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  )
              //DUMMY_Categories is a list so we use map function here to split it up and apply a function
              )
          .toList(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        /*SliverGriddle takes care of structuring the grid
        WIth max cross extent items we can provide a width and it will make as many items as possible on that width*/

        maxCrossAxisExtent: 200,
        childAspectRatio:
            3 / 2, //Provides a ratio of height:width for each child item
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
