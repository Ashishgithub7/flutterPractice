import 'package:favorite_places/model/favorite_place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class FavoritePlaceAddScreen extends ConsumerStatefulWidget {
  const FavoritePlaceAddScreen({super.key});

  

  @override
  ConsumerState<FavoritePlaceAddScreen> createState() =>
      _FavoritePlacesAddScreenState();
}

class _FavoritePlacesAddScreenState extends ConsumerState<FavoritePlaceAddScreen> {
  PlaceLocation? selectedLocation;

  File ?_selectedImage;
  final titleController = TextEditingController();
  void _addPlace() {
    final placeTitle = titleController.text;

    if(placeTitle.isEmpty || _selectedImage==null || selectedLocation == null) return;
    
    final newPlace = FavoritePlace(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: placeTitle,
      image: _selectedImage!,
      location: selectedLocation! ,
    );

    setState(() {
      ref.read(favoritePlacesProvider.notifier).addFavoritePlace(newPlace);
    });

    Navigator.of(context).pop();
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
            ImageInput(onPictureTake: (image){
              _selectedImage=image;
            }),
            SizedBox(height: 8),
            LocationInput(onSelectLocation: (location){
              selectedLocation = location;
            },),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _addPlace();
                  },
                  label: Text("Add Place"),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
