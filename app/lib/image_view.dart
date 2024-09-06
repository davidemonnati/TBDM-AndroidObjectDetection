import 'dart:io';

import 'package:app/response_view.dart';
import 'package:app/service/client_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final XFile image;

  const ImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Column(
          children: [
            Image.file(File(image.path)),
            ElevatedButton(child: const Text("Send"), onPressed: () {
              Future<ImageProvider> imageWithDetections = uploadImage(
                  File(image.path));
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      ResponseView(image: imageWithDetections))
              );
            }),
          ],
        )
    );
  }
}