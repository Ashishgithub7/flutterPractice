import 'dart:convert';

import 'package:favorite_places/model/favorite_place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as https;

class LocationInput extends StatefulWidget{
  LocationInput({super.key, required this._onSelectLocation});

  void Function(PlaceLocation location) _onSelectLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput>{
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImageUrl{
    if(_pickedLocation == null) {
      return '';
    }
    final double lat = _pickedLocation!.latitude;
    final double lng = _pickedLocation!.longitude;
    return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat%3A$lng%2C$lat&zoom=12.3497&marker=lonlat%3A$lng%2C$lat%3Btype%3Amaterial%3Bcolor%3A%23ff0000%3Bsize%3Amedium&apiKey=21a02d547ac342d8821053dcae82fd89';
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
      return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
      return;
      }
    }
    
    setState(() {
      _isGettingLocation = true; // turning on the spinner just before requesting location
    });

    locationData = await location.getLocation();

    setState(() {
      _isGettingLocation = false; //after getting location spinner is turned off
    });

    final double lat = locationData.latitude;
    final double lng = locationData.longitude;
    final addressUrl = Uri.parse('https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lng&apiKey=21a02d547ac342d8821053dcae82fd89');
    final response = await https.get(addressUrl);
    final resData = json.decode(response.body);
    String address = "${resData['features'][0]['properties']['city']}, ${resData['features'][0]['properties']['county']} ";

    setState(() {
      _pickedLocation = PlaceLocation(longitude: lng, latitude: lat, address: address);
      //instead of location image is shown after the _pickedLocation is there
    }); 

    widget._onSelectLocation(_pickedLocation!); 
    // _pickedLocation is sent to the parent favoritePlaceAdd widget/screen to create a favoritePlace object
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text("No location selected.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),);
    if(_pickedLocation != null){
      previewContent = Image.network(locationImageUrl,fit: BoxFit.cover,width: double.infinity,height: double.infinity,);
    }
    if(_isGettingLocation){
      previewContent = CircularProgressIndicator();
    }      
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withAlpha(120),
           ),
          ),
          height: 170,
          width: double.infinity,
          child: previewContent 
          
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              label: Text("Get current location"),
              icon: Icon(Icons.location_on),
              onPressed: getCurrentLocation,
              ),
              TextButton.icon(
              label: Text("Select on map"),
              icon: Icon(Icons.map),
              onPressed: (){},
              ),
          ],
        )
      ],
    );
  }
}