import 'package:favorite_places/model/favorite_place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaceAddScreen extends ConsumerStatefulWidget {
  FavoritePlaceAddScreen({super.key});

  @override
  ConsumerState<FavoritePlaceAddScreen> createState() =>
      _FavoritePlacesAddScreenState();
}

class _FavoritePlacesAddScreenState
    extends ConsumerState<FavoritePlaceAddScreen> {
  final titleController = TextEditingController();
  void _addPlace() {
    final placeTitle = titleController.text;
    final newPlace = FavoritePlace(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: placeTitle,
    );
    setState(() {
      ref.read(favoritePlacesProvider.notifier).addFavoritePlace(newPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add favorite places")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(label: Text('Place Title')),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addPlace();
                  },
                  child: Text("Add Place"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
