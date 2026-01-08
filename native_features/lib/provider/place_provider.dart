import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:native_features/model/place.dart';
import 'package:path_provider/path_provider.dart' as softpath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserStateNotifier extends StateNotifier<List<Place>> {
  UserStateNotifier() : super(const []);

  Future<void> loadPlace() async {
    final db = await getDB();

    final tableData = await db.query('user_places');

    final places = tableData
        .map(
          (row) => Place(
            id: row['id'] as String,
            image: File(row['image'] as String),
            title: row['title'] as String,
            placelocation: PlaceLocation(
              lon: row['lon'] as double,
              lat: row['lat'] as double,
              address: row['address'] as String,
            ),
            locUrl: row['locationURL'] as String,
          ),
        )
        .toList();
    state = places;
  }

  Future<Database> getDB() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) => db.execute(
        'CREATE TABLE user_places(id PRIMARY KEY, title TEXT, image TEXT, locationURL TEXT, lat REAL, lon REAL, address TEXT )',
      ),
      version: 1,
    );
    return db;
  }

  void addPlace(
    String title,
    File image,
    PlaceLocation placelocation,
    String url,
  ) async {
    final appDir = await softpath.getApplicationDocumentsDirectory();
    final imgName = path.basename(image.path);
    final copiedImg = await image.copy('${appDir.path}/$imgName');

    final newPlace = Place(
      title: title,
      image: copiedImg,
      placelocation: placelocation,
      locUrl: url,
    );
    final db = await getDB();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'locationURL': newPlace.locUrl,
      'lon': newPlace.placelocation.lon,
      'lat': newPlace.placelocation.lat,
      'address': newPlace.placelocation.address,
    });

    state = [newPlace, ...state];
  }
}

final userPlaceProvier = StateNotifierProvider<UserStateNotifier, List<Place>>(
  (ref) => UserStateNotifier(),
);
