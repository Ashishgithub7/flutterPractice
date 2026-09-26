import "dart:io";
import 'package:uuid/uuid.dart';

final uuid = Uuid();
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
    String? id,
    required this.title,
    required this.image,
    required this.location
  }): id = id ?? uuid.v4();
  
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}