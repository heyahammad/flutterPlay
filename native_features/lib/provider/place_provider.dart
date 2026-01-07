import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:native_features/model/place.dart';

class UserStateNotifier extends StateNotifier<List<Place>> {
  UserStateNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);

    state = [newPlace, ...state];
  }
}

final userPlaceProvier = StateNotifierProvider<UserStateNotifier, List<Place>>(
  (ref) => UserStateNotifier(),
);
