import 'package:riverpod/legacy.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'dart:io';

import 'package:favorite_places/model/favorite_place.dart';

final List<FavoritePlace> favorite_places = [];

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier() : super([]);
  Future<Database> _getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map(
      (row) => FavoritePlace(
          id: row['id'] as String,
          title: row['title'] as String,
          image: File(row['image'] as String),
          location: PlaceLocation(
            longitude: row['lng'] as double,
            latitude: row['lat'] as double,
            address: row['address'] as String,
          ),
        ),
    ).toList();
    state = places;
  }

  void addFavoritePlace(FavoritePlace favoritePlace) async {
    final db = await _getDatabase();
    db.insert('user_places', {
      'id': favoritePlace.id,
      'title': favoritePlace.title,
      'image': favoritePlace.image.path,
      'lat': favoritePlace.location.latitude,
      'lng': favoritePlace.location.longitude,
      'address': favoritePlace.location.address,
    });

    state = [...state, favoritePlace];
  }

  void removeFavoritePlace(FavoritePlace favoritePlace) {
    state = state.where((place) => place.title != favoritePlace.title).toList();
  }
}

final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<FavoritePlace>>((ref) {
      return FavoritePlacesNotifier();
    });
