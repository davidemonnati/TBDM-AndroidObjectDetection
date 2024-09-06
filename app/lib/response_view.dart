import 'package:flutter/material.dart';

class ResponseView extends StatelessWidget {
  final Future<ImageProvider> image;

  const ResponseView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Display image")),
        body: Column(
          children: [
            FutureBuilder(
                future: image,
                builder: (BuildContext context,
                    AsyncSnapshot<ImageProvider> snapshot) {
                  return Image(image: snapshot.requireData);
                }
            )
          ],
        )
    );
  }
}