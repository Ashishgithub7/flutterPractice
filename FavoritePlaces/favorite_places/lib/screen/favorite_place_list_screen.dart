import 'package:favorite_places/model/favorite_place.dart';
import 'package:favorite_places/providers/favorite_places_provider.dart';
import 'package:favorite_places/screen/favorite_place_add_screen.dart';
import 'package:favorite_places/screen/favorite_place_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class FavoritePlaceListScreen extends ConsumerStatefulWidget {
  FavoritePlaceListScreen({super.key});

  ConsumerState<FavoritePlaceListScreen> createState() =>
      _FavoritePlaceListScreenState();
}

class _FavoritePlaceListScreenState
    extends ConsumerState<FavoritePlaceListScreen> {
  void openDetails(FavoritePlace place) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => FavoritePlaceDetailScreen(place: place,)));
  }
  void _addPlaces() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => FavoritePlaceAddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    List<FavoritePlace> favoritePlaces = ref.watch(favoritePlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Places"),
        actions: [IconButton(onPressed: _addPlaces, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            for (final place in favoritePlaces)
              ListTile(
                title: Text(place.title),
                onTap: () {
                  openDetails(place);
                },
                // style: ListTileStyle.list,
              ),
          ],
        ),
      ),
    );
  }
}
