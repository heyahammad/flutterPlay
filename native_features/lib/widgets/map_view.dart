import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:native_features/model/place.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    this.location = const PlaceLocation(
      lat: 23.760357934595962,
      lon: 90.34925560951883,
      address: 'Tong, Field Access Road, Mohammadpur, Dhaka - 1207, Bangladesh',
    ),
    this.isSelecteing = true,
  });

  final PlaceLocation location;
  final bool isSelecteing;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  LatLng? pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecteing ? 'Select you location' : 'Your location',
        ),
        actions: [
          if (widget.isSelecteing)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(pickedLocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(widget.location.lat, widget.location.lon),
          initialZoom: 15,
          onTap: (tapPosition, point) {
            setState(() {
              pickedLocation = point;
            });
          },
        ),

        children: [
          TileLayer(
            urlTemplate:
                'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?&apiKey=ff6d177b342d473fa403203f2ae0b987',
            userAgentPackageName: 'com.example.app',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: pickedLocation != null && widget.isSelecteing == true
                    ? pickedLocation!
                    : LatLng(widget.location.lat, widget.location.lon),
                width: 40,
                height: 40,
                child: Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
