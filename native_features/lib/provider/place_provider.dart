import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:native_features/model/place.dart';

class UserStateNotifier extends StateNotifier<List<Place>> {
  UserStateNotifier() : super(const []);

  void addPlace(String title, File image, PlaceLocation placelocation) {
    final newPlace = Place(
      title: title,
      image: image,
      placelocation: placelocation,
    );

    state = [newPlace, ...state];
  }
}

final userPlaceProvier = StateNotifierProvider<UserStateNotifier, List<Place>>(
  (ref) => UserStateNotifier(),
);
