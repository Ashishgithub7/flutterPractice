import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/Provider/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  
  @override
  Widget build(context,WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters",)
        ,),
        body: Column(
            children: [
              SwitchListTile(
                value: activeFilters[Filters.glutenFree]!, 
                onChanged: (isChecked){
                  ref.read(filterProvider.notifier).
                  setFilter(Filters.glutenFree, isChecked);
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
                value: activeFilters[Filters.lactoseFree]!, 
                onChanged: (isChecked){
                  ref.read(filterProvider.notifier).
                  setFilter(Filters.lactoseFree, isChecked);
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
                value: activeFilters[Filters.vegetarian]!, 
                onChanged: (isChecked){
                  ref.read(filterProvider.notifier).
                  setFilter(Filters.vegetarian, isChecked);
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
                value: activeFilters[Filters.vegan]!, 
                onChanged: (isChecked){
                  ref.read(filterProvider.notifier).
                  setFilter(Filters.vegan, isChecked);
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
        );
  }
}
