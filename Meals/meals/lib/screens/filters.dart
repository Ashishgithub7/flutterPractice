import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

bool glutenFree = false;
bool lactoseFree = false;
bool vegetarian = false;
bool vegan = false;

enum Filters{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters",)
        ,),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop,result) {
            if(didPop) return;
            Navigator.of(context).pop({
              Filters.glutenFree: glutenFree,
              Filters.lactoseFree: lactoseFree,
              Filters.vegetarian: vegetarian,
              Filters.vegan: vegan,
          });
          },
          child: Column(
            children: [
              SwitchListTile(
                value: glutenFree, 
                onChanged: (isChecked){
                  setState((){
                    glutenFree = isChecked;
                  });
                },
                title: Text("Gluten Free", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),
                ),
                subtitle: Text(
                  "Only include gluten-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary
                ),),
                ),
                SwitchListTile(
                value: lactoseFree, 
                onChanged: (isChecked){
                  setState((){
                    lactoseFree = isChecked;
                  });
                },
                title: Text("Lactose Free", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),
                ),
                subtitle: Text(
                  "Only include lactose-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary
                ),),
                ),
                SwitchListTile(
                value: vegetarian, 
                onChanged: (isChecked){
                  setState((){
                    vegetarian = isChecked;
                  });
                },
                title: Text("Vegetarian", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),
                ),
                subtitle: Text(
                  "Only include vegetarian meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary
                ),),
                ),
                SwitchListTile(
                value: vegan, 
                onChanged: (isChecked){
                  setState((){
                    vegan = isChecked;
                  });
                },
                title: Text("Vegan", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface
                ),
                ),
                subtitle: Text(
                  "Only include vegan meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary
                ),),
                ),
            ],
          ),
        ),
        );
  }
}
