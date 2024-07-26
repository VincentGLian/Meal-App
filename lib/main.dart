import 'package:flutter/material.dart';
import './dummy_data.dart';
import './screens/filters.dart';
import './screens/tabs.dart';
import './screens/meal_detail.dart';
import './screens/category_meals.dart';
import './screens/categories.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              titleLarge: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: Categories(),
      routes: {
        '/': (ctx) => Tabs(favoriteMeals),

        CategoryMeals.routeName: (ctx) => CategoryMeals(availableMeals),
        // '/category-meals': (ctx) => CategoryMeals(),

        MealDetail.routeName: (ctx) =>
            MealDetail(toggleFavorite, isMealFavorite),
        Filters.routeName: (ctx) => Filters(filters, setFilters),
      },

      //if going to a screen that isn't defined in routes above
      // onGenerateRoute: (settings) {
      //   return MaterialPageRoute(builder: (ctx) => Categories());
      // },

      //if going to somewhere that doesn't exist
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => Categories());
      },
    );
  }
}
