import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/model/meal.dart';
import 'package:meals/Provider/favorite_meals_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context,)
              .showSnackBar(
                SnackBar(content: Text(wasAdded ? "${meal.title} added to favorites" : "${meal.title} removed from favorites")));
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    meal.imageUrl,
                    height: 300,
                    width: double.infinity * 0.8,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),

                SizedBox(height: 8),
                for (final ingredient in meal.ingredients)
                  Text(
                    '- $ingredient',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                SizedBox(height: 16),
                Text(
                  'Steps',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: 8),
                for (final step in meal.steps)
                  Text(
                    step,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
