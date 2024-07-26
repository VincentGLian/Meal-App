import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';
import './favorites.dart';
import './categories.dart';
import '../models/meal.dart';

class Tabs extends StatefulWidget {
  final List<Meal> favoriteMeals;

  Tabs(this.favoriteMeals);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<Map<String, Object>> pages;
  int selectedPageIndex = 0;

  @override
  void initState() {
    pages = [
      {'page': Categories(), 'title': 'Categories'},
      {'page': Favorites(widget.favoriteMeals), 'title': 'Your Favorites'},
    ];
    super.initState();
  }

  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: selectedPageIndex,
        //adds animation to the bottombar
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            //if type is shifting
            //backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Categories',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            //if type is shifting
            //backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Favorites',
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );

    //for tabbar below appbar title
    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('DeliMeal'),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(children: [
    //       Categories(),
    //       Favorites(),
    //     ]),
    //   ),
    // );
  }
}
