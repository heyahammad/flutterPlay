import 'package:flutter/material.dart';
import 'package:location/location.dart';

class DetectLocation extends StatefulWidget {
  const DetectLocation({super.key});

  @override
  State<DetectLocation> createState() => _DetectLocationState();
}

class _DetectLocationState extends State<DetectLocation> {
  LocationData? loc;
  bool loading = false;

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
      loading = true;
    });

    locationData = await location.getLocation();
    setState(() {
      loading = false;
    });
    loc = locationData;
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
              onPressed: () {},
              label: Text('Choose on map'),
            ),
          ],
        ),
      ],
    );
  }
}
