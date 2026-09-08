import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/category.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/list_item.dart';
import 'package:shopping_list/screens/add_item_screen.dart';


class GroceryListScreen extends ConsumerStatefulWidget {
  const GroceryListScreen({super.key});

  @override
  ConsumerState<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends ConsumerState<GroceryListScreen> {
  List<GroceryItem> groceryItems = [];
  var _isLoading = true; 
  String? error;

  @override
  void initState() {
    super.initState();
    _onLoadItems();
  }
  void _onLoadItems() async{
    final url = Uri.https('flutter-practice-b8935-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    print("check if null: "+ response.body);
    if(response.body== 'null'){
      setState(() {
        _isLoading = false;
      });
      return;// in the case of no items firebase sends null string in the body of response which is handled here
    } 
    if(response.statusCode >=400){
      setState(() {
        error = "Couldn't connect to server. Please try again later.";
      });
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> responseList = [];
    
      for (final item in listData.entries){
        // final categories = categories.entries
       responseList.add(
        GroceryItem(
          id: item.key, 
          name: item.value['name'], 
          quantity: item.value['quantity'], 
          // category: categories[item.value['category']]!,
          category: categories[Categories.values.byName(item.value['category'].toString().toLowerCase())]!,
          ),
          );
    }  
    setState(() {
      groceryItems = responseList;
    });

    // print(response.body);
    
  }

  void _addItem() async {
      final newGroceryItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const AddItemScreen(),
      ),
    );
    if(newGroceryItem == null) return;
    setState(() {
        groceryItems.add(newGroceryItem);
      // ref.read(groceryProvider.notifier).addGroceryItem(newItem); if riverpod provider is used
    }); 
  }
  void _onRemove(GroceryItem item) async{
    final index = groceryItems.indexOf(item); 
    setState(() {
      groceryItems.remove(item);
    });

    final urlDelete = Uri.https('flutter-practice-b8935-default-rtdb.firebaseio.com', '/shopping-list/${item.id}.json');
    final response = await http.delete(urlDelete); 
    if(response.statusCode>=400){
    print("DEBUG: The item ID is -> '${item.id}'");

      print(response.body);
      print(response.statusCode);
      setState(() {
        groceryItems.insert(index, item);
      });
    }
   }
  
  
  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text("No items in the list!"));
    if(_isLoading){
      content = Center( child: CircularProgressIndicator(),);
    }
    if(error!=null){
      content =  Center(child: Text(error!));
    }
    
    // final groceryItems = ref.watch(groceryProvider); using riverpod provider
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed:_addItem,
            icon: const Icon(Icons.add),
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: groceryItems.isNotEmpty ? Column(
        children:[for(final item in groceryItems)
          ListItem(groceryItem: item,onRemove: _onRemove,)
        ] 
      ):content,
      ),
    );
  }
}