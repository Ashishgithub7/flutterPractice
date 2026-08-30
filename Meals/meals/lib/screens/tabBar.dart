import 'package:flutter/material.dart';
import 'package:meals/data/dummy_categories_data.dart';
import 'package:meals/main.dart';
import 'package:meals/model/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/drawer.dart';

const kInitialFilters = {
  Filters.glutenFree : false,
  Filters.lactoseFree : false,
  Filters.vegetarian : false,
  Filters.vegan : false
};

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() {
    return _TabBarScreenState();
  }
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedTabIndex = 0;

  var _selectedFilters = kInitialFilters;

  final List<Meal> favoriteMeals = [];
  void favoriteAddRemoveMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onToggleFavorite(Meal meal) {
    bool isExisting = favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      favoriteAddRemoveMessage("${meal.title} removed from favorites");
    } else {
      setState(() {
        favoriteMeals.add(meal);
      });
      favoriteAddRemoveMessage("${meal.title} added to favorites");
    }
  }

  void _onTabSelection(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onSelectDrawer(String keyword) async {
    Navigator.of(context).pop();
    if (keyword == "filters") { 
     final result = await Navigator.of(
        context,
      ).push<Map<Filters,bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
          ),
          );
           setState(() {
            _selectedFilters = result ?? kInitialFilters;
           });
    } 
  }

  @override
  Widget build(BuildContext context) {
      var _availableMeals = dummyMeals.where((meal){
      if(_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filters.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget _selectedScreen = CategoriesScreen(
      onToggleFavorite: _onToggleFavorite,
      availableMeals : _availableMeals
    );
    String selectedTitle = "Categories";
    if (_selectedTabIndex == 1) {
      _selectedScreen = MealsScreen(
        meals: favoriteMeals,
        onToggleFavorite: _onToggleFavorite,
      );
      selectedTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(selectedTitle)),
      drawer: SideDrawer(setScreenFromDrawer: _onSelectDrawer),
      body: _selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabSelection,
        currentIndex: _selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favourite"),
        ],
      ),
    );
  }
}
