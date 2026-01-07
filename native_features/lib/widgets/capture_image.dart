import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CaptureImage extends StatefulWidget {
  const CaptureImage({super.key, required this.selectedCapturedImage});
  final void Function(File image) selectedCapturedImage;

  @override
  State<CaptureImage> createState() => _CaptureImageState();
}

class _CaptureImageState extends State<CaptureImage> {
  File? selectedImage;

  void capture() async {
    final imagePicker = ImagePicker();

    final capturedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (capturedImage == null) {
      return;
    }

    setState(() {
      selectedImage = File(capturedImage.path);
    });

    widget.selectedCapturedImage(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: Icon(Icons.camera, size: 25),
      onPressed: () {
        capture();
      },
      label: Text('Capture', style: TextStyle(fontSize: 20)),
      style: Theme.of(context).textButtonTheme.style,
    );

    if (selectedImage != null) {
      content = Image.file(
        selectedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.primary.withAlpha(70),
        ),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      height: 300,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => capture(),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: content,
          ),
        ),
      ),
    );
  }
}
