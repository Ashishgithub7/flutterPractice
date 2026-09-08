import 'package:flutter_riverpod/legacy.dart';
import 'package:shopping_list/models/grocery_item.dart';

// StateNotifier comes from the state_notifier package; StateNotifierProvider
// comes from flutter_riverpod. Both imports are required for this provider.
class GroceryNotifier extends StateNotifier<List<GroceryItem>>{
  GroceryNotifier() :super([]);

  void addGroceryItem(GroceryItem newGroceryItem){
    state = [...state,newGroceryItem];
  }

  void removeGroceryItem(GroceryItem item){
    state = state.where((i)=> i.id != item.id).toList();
  }
}
final groceryProvider = StateNotifierProvider<GroceryNotifier, List<GroceryItem>>((ref){
  return GroceryNotifier();
});