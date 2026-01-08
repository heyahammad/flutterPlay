import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:native_features/model/place.dart';
import 'package:native_features/widgets/map_view.dart';

class DetectLocation extends StatefulWidget {
  const DetectLocation({
    super.key,
    required this.placeLocation,
    required this.locUrl,
  });
  final void Function(PlaceLocation loc) placeLocation;
  final void Function(String url) locUrl;

  @override
  State<DetectLocation> createState() => _DetectLocationState();
}

class _DetectLocationState extends State<DetectLocation> {
  bool loading = false;
  PlaceLocation? pickedlocation;
  String? lUrl;
  LocationData? locData;

  void fetchLocImage() async {
    double lon = locData!.longitude!;
    double lat = locData!.latitude!;

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'com.example.app'},
    );

    if (response.statusCode == 200) {
      final info = jsonDecode(response.body);
      lUrl = Uri.https('maps.geoapify.com', '/v1/staticmap', {
        'style': 'osm-bright-smooth',
        'width': '600',
        'height': '600',
        'center': 'lonlat:$lon,$lat',
        'zoom': '14.3497',
        'marker': 'lonlat:$lon,$lat;type:awesome;color:#bb3f73;size:x-large',
        'apiKey': 'ff6d177b342d473fa403203f2ae0b987',
      }).toString();
      pickedlocation = PlaceLocation(
        lon: lon,
        lat: lat,
        address: info['display_name'].toString(),
      );

      widget.locUrl(lUrl!);

      widget.placeLocation(pickedlocation!);
    } else {
      print('error ${response.statusCode}');
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

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
      loading = true;
    });

    locData = await location.getLocation();

    if (locData != null) {
      fetchLocImage();
    }

    setState(() {
      loading = false;
    });
  }

  void selectOnMap() async {
    final locationData = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => MapWidget(isSelecteing: true)),
    );

    if (locationData != null) {
      setState(() {
        locData = LocationData.fromMap({
          'latitude': locationData.latitude,
          'longitude': locationData.longitude,
        });
      });
      getCurrentLocation();
      fetchLocImage();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No location selected',
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );

    if (loading) {
      content = CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      );
    } else if (pickedlocation != null) {
      content = ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image.network(
          lUrl!,
          fit: BoxFit.cover,
          height: 600,
          width: double.infinity,
        ),
      );
    }

    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary.withAlpha(70),
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: content,
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: Icon(Icons.add_location),
              onPressed: () {
                getCurrentLocation();
              },
              label: Text('Current location'),
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              onPressed: () {
                selectOnMap();
              },
              label: Text('Choose on map'),
            ),
          ],
        ),
      ],
    );
  }
}
