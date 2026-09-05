import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list/data/dummy_items.dart';


final groceryProvider = Provider((ref){
  return groceryItems;
});