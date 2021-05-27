import 'package:flutter/material.dart';
import 'package:meal/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> currentfilter;
  final Function savedFilters;
  FiltersScreen(this.currentfilter,
      this.savedFilters); //For capturing sent value from main.dart file

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isglutenFree =
      false; //We can't set currentfilter values here we have to use initState to do that
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    //By doin this we are making sure that the value of filters remained saved when we open it up again
    _isglutenFree = widget.currentfilter['gluten'];
    _vegetarian = widget.currentfilter['vegetarian'];
    _vegan = widget.currentfilter['vegan'];
    _lactoseFree = widget.currentfilter['lactose'];
    super.initState();
  }

  Widget _buildSwitchTitle(
      String text, bool val, String subtitle, Function change) {
    return SwitchListTile(
        title: Text(text),
        value: val, //state is managed ie true or false
        subtitle: Text(subtitle),
        onChanged: change);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Note that u automatically get a back button in case of pushNamed
      //If we don't add Sccafold here then the wholescreen will be black
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _isglutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };
              widget.savedFilters(selectedFilters);
            }, //In stateful widget i can refer to the widget outside class using widget
          )
        ],
      ),
      drawer: MainDrawer(), //Replaces the backbutton with the hamburger drawer
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection',
                style: Theme.of(context).textTheme.title),
          ),
          Expanded(
              child: ListView(
            //We can use Expanded here so that it only takes the space which is available to it
            children: <Widget>[
              _buildSwitchTitle(
                'GluttenFree',
                _isglutenFree,
                'Only Includes Glutten Free meals',
                (newvalue) {
                  //newvalue gets filled up with true or false whatever the new state of listtile is
                  //You can't put this function in builder method buildSwitchTitle because then newValue won't get filled
                  setState(() {
                    _isglutenFree = newvalue;
                  });
                },
              ),
              _buildSwitchTitle(
                'Vegetarian',
                _vegetarian,
                'Only Includes Vegetarian meals',
                (newvalue) {
                  setState(() {
                    _vegetarian = newvalue;
                  });
                },
              ),
              _buildSwitchTitle('Vegan', _vegan, 'Only Includes Vegan meals',
                  (newvalue) {
                //newvalue gets filled up with true or false whatever the new state of listtile is
                setState(() {
                  _vegan = newvalue;
                });
              }),
              _buildSwitchTitle('Lactose Free', _lactoseFree,
                  'Only Includes Lactose Free meals', (newvalue) {
                //newvalue gets filled up with true or false whatever the new state of listtile is
                setState(() {
                  _lactoseFree = newvalue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
