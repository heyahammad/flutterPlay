import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/model/place.dart';
import 'package:native_features/widgets/map_view.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.name,
    required this.id,
    required this.image,
    required this.placeLocation,
    required this.locUrl,
  });
  final String name;
  final String id;
  final File image;
  final PlaceLocation placeLocation;
  final String locUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 80,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MapWidget(
                        location: placeLocation,
                        isSelecteing: false,
                      ),
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(locUrl),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Text(
                    placeLocation.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
