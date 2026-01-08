import 'dart:io';
import 'package:uuid/uuid.dart' as uuid;

const pid = uuid.Uuid();

class Place {
  Place({
    required this.title,
    required this.image,
    required this.placelocation,
    required this.locUrl,
    String? id,
  }) : id = id ?? pid.v4();
  final String title;
  final String id;
  final File image;
  final PlaceLocation placelocation;
  String locUrl;
}

class PlaceLocation {
  const PlaceLocation({
    required this.lon,
    required this.lat,
    required this.address,
  });
  final double lon;
  final double lat;
  final String address;
}
