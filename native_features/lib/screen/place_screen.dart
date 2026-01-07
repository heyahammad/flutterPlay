import 'dart:io';

import 'package:flutter/material.dart';
import 'package:native_features/model/place.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.name,
    required this.id,
    required this.image,
    required this.placeLocation,
  });
  final String name;
  final String id;
  final File image;
  final PlaceLocation placeLocation;
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
            left: 10,
            right: 10,
            bottom: 70,
            child: Container(
              alignment: Alignment.center,
              height: 300,
              width: 200,
              child: Image.network(placeLocation.locUrl),
            ),
          ),
        ],
      ),
    );
  }
}
