import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features/model/place.dart';
import 'package:native_features/provider/place_provider.dart';
import 'package:native_features/widgets/capture_image.dart';
import 'package:native_features/widgets/detect_location.dart';

class PlaceAdd extends ConsumerStatefulWidget {
  const PlaceAdd({super.key});

  @override
  ConsumerState<PlaceAdd> createState() => _PlaceAddState();
}

class _PlaceAddState extends ConsumerState<PlaceAdd> {
  final _keyform = GlobalKey<FormState>();
  String placeTitle = '';
  File? cappedImage;
  PlaceLocation? placeLoc;
  String? locUrl;

  void addPlace() {
    if (_keyform.currentState!.validate()) {
      _keyform.currentState!.save();

      ref
          .read(userPlaceProvier.notifier)
          .addPlace(placeTitle, cappedImage!, placeLoc!, locUrl!);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Place',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Form(
        key: _keyform,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(label: Text('Enter a place name')),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length >= 50) {
                    return 'Please enter a place name (1-50)';
                  }
                  return null;
                },
                onSaved: (value) {
                  placeTitle = value.toString();
                },
              ),
              SizedBox(height: 10),
              CaptureImage(
                selectedCapturedImage: (image) {
                  cappedImage = image;
                },
              ),
              SizedBox(height: 10),
              DetectLocation(
                placeLocation: (loc) {
                  placeLoc = loc;
                },
                locUrl: (url) {
                  locUrl = url;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _keyform.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addPlace();
                    },
                    child: Text('Add Place'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
