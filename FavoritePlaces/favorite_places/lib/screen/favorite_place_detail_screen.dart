import 'package:favorite_places/model/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritePlaceDetailScreen extends ConsumerStatefulWidget {
  FavoritePlaceDetailScreen({super.key, required this.place});
  final FavoritePlace place;
  @override
  ConsumerState<FavoritePlaceDetailScreen> createState() {
    return _FavoritePlaceDetailScreenState();
  }
}

class _FavoritePlaceDetailScreenState
    extends ConsumerState<FavoritePlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.place.title)),
      body: Center(
        child: Text(widget.place.title,style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
        ),
    );
  }
}
