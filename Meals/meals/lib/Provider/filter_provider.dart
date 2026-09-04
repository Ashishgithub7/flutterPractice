import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_categories_data.dart';

enum Filters{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filters,bool>>{
  FilterNotifier():super({
    Filters.glutenFree : false,
    Filters.lactoseFree : false,
    Filters.vegetarian : false,
    Filters.vegan : false
  });

  void setFilter(Filters filter, bool isActive){
    state = {
      ...state,
      filter : isActive
    };
  }

  void setFilters(Map<Filters,bool> filters){
    state = filters;
  }
}
final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filters, bool>>((ref) {
  return FilterNotifier();
});

final filteredMealsProvider = Provider((ref){
  final activeFilters = ref.watch(filterProvider);
  return dummyMeals.where((meal){
      if(activeFilters[Filters.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(activeFilters[Filters.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(activeFilters[Filters.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
});