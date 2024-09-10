import 'dart:io';

import 'package:app/response_view.dart';
import 'package:app/service/client_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  const ImageView({super.key, required this.image});
  final XFile image;

  State<ImageView> createState() => _ImageViewState(image: image);
}

class _ImageViewState extends State<ImageView> {
  _ImageViewState({required this.image});

  final XFile image;
  static bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: Column(
          children: [
            Image.file(File(image.path)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 24),
                  minimumSize: const Size.fromHeight(55),
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.lightBlue,
                ),
                onPressed: () {
                  setState(() => loading = true);
                  uploadImage(File(image.path)).then((image) {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ResponseView(image: image))
                    );
                    setState(() => loading = false);
                  }).onError((e, s) {
                    setState(() => loading = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: const Text(
                                "A connection error occurred"),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {},
                            )
                        )
                    );
                  });
                },
                child: loading ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(width: 24),
                    Text("Processing image..."),
                  ],
                ) : const Text("Send")
            ), //SnackBar(content: content)
          ],
        )
    );
  }
}
