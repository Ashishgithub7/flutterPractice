import 'package:favorite_places/model/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaceDetailScreen extends ConsumerStatefulWidget {
  const FavoritePlaceDetailScreen({super.key, required this.place});
  final FavoritePlace place;
  @override
  ConsumerState<FavoritePlaceDetailScreen> createState() {
    return _FavoritePlaceDetailScreenState();
  }
}

class _FavoritePlaceDetailScreenState extends ConsumerState<FavoritePlaceDetailScreen> {
  String get locationImageUrl{
    
    final double lat = widget.place.location.latitude;
    final double lng = widget.place.location.longitude;
    return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat%3A$lng%2C$lat&zoom=12.3497&marker=lonlat%3A$lng%2C$lat%3Btype%3Amaterial%3Bcolor%3A%23ff0000%3Bsize%3Amedium&apiKey=21a02d547ac342d8821053dcae82fd89';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.place.title)),
      body: Stack(
        children: [
          Image.file(
            widget.place.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CircleAvatar(radius: 70, backgroundImage: NetworkImage(locationImageUrl),),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: AlignmentGeometry.topCenter,
                      end: AlignmentGeometry.bottomCenter,
                    ),
                  ),
                  child: Text(widget.place.location.address, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    ),
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
