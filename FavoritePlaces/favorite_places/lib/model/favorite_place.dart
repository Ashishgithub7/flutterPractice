import "dart:io";

class PlaceLocation{
  PlaceLocation({
    required this.longitude, 
    required this.latitude, 
    required this.address
    });

  final double latitude;
  final double longitude;
  final String address;
}


class FavoritePlace {
  FavoritePlace({
    required this.id,
    required this.title,
    required this.image,
    required this.location
  });
  
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}