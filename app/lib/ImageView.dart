import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final XFile image;

  const ImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Image.file(File(image.path))
    );
  }
}