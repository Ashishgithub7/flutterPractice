import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';


class ListItem extends StatefulWidget{
   const ListItem({super.key, required this.groceryItem, required this.onRemove});
   final Function (GroceryItem) onRemove;

   final GroceryItem groceryItem;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  String? error;
   

   @override
   Widget build(BuildContext context) {
      return Dismissible(
        key: ValueKey(widget.groceryItem),
        onDismissed: (direction){
          widget.onRemove(widget.groceryItem);
        } ,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children:[
              Icon(Icons.square_rounded, color: widget.groceryItem.category.color, size: 30,),
              const SizedBox(width: 32),
              Text( 
                widget.groceryItem.name, 
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),
              ),
              Spacer(),
              Text(widget.groceryItem.quantity.toString(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),),
            ],
          ),
        ),
      );
   }
}