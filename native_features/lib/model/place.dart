import 'dart:io';
import 'package:uuid/uuid.dart' as uuid;

const pid = uuid.Uuid();

class Place {
  Place({required this.title, required this.image, required this.placelocation})
    : id = pid.v4();
  final String title;
  final String id;
  final File image;
  final PlaceLocation placelocation;
}

class PlaceLocation {
  PlaceLocation({
    required this.lon,
    required this.lat,
    required this.address,
    required this.locUrl,
  });
  String locUrl;
  double lon;
  double lat;
  String address;
}
