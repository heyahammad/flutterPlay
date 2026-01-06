import 'package:flutter_riverpod/legacy.dart';
import 'package:native_features/model/place.dart';

class UserStateNotifier extends StateNotifier<List<Place>> {
  UserStateNotifier() : super(const []);

  void addPlace(String title) {
    final newPlace = Place(title: title);

    state = [newPlace, ...state];
  }
}

final userPlaceProvier = StateNotifierProvider((ref) => UserStateNotifier());
