import 'package:flutter/material.dart';

import 'package:shopping_list/models/grocery_item.dart';


class ListItem extends StatelessWidget{
   const ListItem({super.key, required this.groceryItem});
  
   final GroceryItem groceryItem;

   @override
   Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children:[
            Icon(Icons.square_rounded, color: groceryItem.category.color, size: 30,),
            const SizedBox(width: 32),
            Text( 
              groceryItem.name, 
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface
              ),
            ),
            Spacer(),
            Text(groceryItem.quantity.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface
              ),),
          ],
        ),
      );
   }
}