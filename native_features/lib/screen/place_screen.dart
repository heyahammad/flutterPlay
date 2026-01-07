import 'dart:io';

import 'package:flutter/material.dart';

class PlaceScreen extends StatelessWidget {
  const PlaceScreen({
    super.key,
    required this.name,
    required this.id,
    required this.image,
  });
  final String name;
  final String id;
  final File image;
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
      body: Center(child: Image.file(image)),
    );
  }
}
