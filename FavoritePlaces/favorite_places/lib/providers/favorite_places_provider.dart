import 'package:riverpod/legacy.dart';

import 'package:favorite_places/model/favorite_place.dart';

final List<FavoritePlace> favorite_places = [];

class FavoritePlacesNotifier extends StateNotifier<List<FavoritePlace>> {
  FavoritePlacesNotifier(): super([]);

  void addFavoritePlace(FavoritePlace favoritePlace){
    state = [...state, favoritePlace];
  }

  void removeFavoritePlace(FavoritePlace favoritePlace){
    state = state.where((place)=> place.title != favoritePlace.title).toList();
  }
}

final favoritePlacesProvider = StateNotifierProvider<FavoritePlacesNotifier,List<FavoritePlace>>((ref){
  return FavoritePlacesNotifier();
});