import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class Filters extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  Filters(this.currentFilters, this.saveFilters);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var glutenFree = false;
  var lactoseFree = false;
  var vegan = false;
  var vegetarian = false;

  @override
  void initState() {
    glutenFree = widget.currentFilters['gluten'];
    lactoseFree = widget.currentFilters['lactose'];
    vegan = widget.currentFilters['vegan'];
    vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget buildSwitchList(
      String title, String subtitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text'),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': glutenFree,
                  'lactose': lactoseFree,
                  'vegan': vegan,
                  'vegetarian': vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              buildSwitchList(
                'Gluten Free',
                'Only include gluten free meals',
                glutenFree,
                (newValue) {
                  setState(() {
                    glutenFree = newValue;
                  });
                },
              ),
              buildSwitchList(
                'Lactose Free',
                'Only include lactose free meals',
                lactoseFree,
                (newValue) {
                  setState(() {
                    lactoseFree = newValue;
                  });
                },
              ),
              buildSwitchList(
                'Vegetarian',
                'Only include vegetarian meals',
                vegetarian,
                (newValue) {
                  setState(() {
                    vegetarian = newValue;
                  });
                },
              ),
              buildSwitchList(
                'Vegan',
                'Only include vegan meals',
                vegan,
                (newValue) {
                  setState(() {
                    vegan = newValue;
                  });
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
