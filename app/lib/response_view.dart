import 'dart:math';

import 'package:flutter/material.dart';

class ResponseView extends StatefulWidget {
  const ResponseView({super.key, required this.image});
  final ImageProvider image;

  State<ResponseView> createState() => _ResponseViewState(image: image);
}

class _ResponseViewState extends State<ResponseView> {
  final ImageProvider image;

  _ResponseViewState({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .width * 0.3,
              child: RichText(
                  text: const TextSpan(
                      text: 'Preview',
                      style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'cabin',
                      )
                  )
              ),
            ),
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Transform.rotate(
                angle: 90 * pi / 180,
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(100),
                  maxScale: 3,
                  child: Image(image: image),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Row(
                  children: [
                    Expanded(
                        child: _buildButtons(
                            Colors.white, Icons.delete_outlined, 'Delete',
                            deleteImage)
                    ),
                    Expanded(
                        child: _buildButtons(
                            Colors.white, Icons.archive_outlined, 'Save',
                            saveImage)
                    ),
                  ],
                )
            )
          ]
      ),
    );
  }

  Column _buildButtons(Color color, IconData icon, String label,
      Function() function) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: () => function(),
            child: Icon(icon, color: color, size: 40)),
        //Icon(icon, color: color, size: 40),
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color
            ),
          ),
        )
      ],
    );
  }

  void saveImage() {
    // TODO: inserire logica per il salvataggio della foto a BE
  }

  void deleteImage() {
    Navigator.of(context).pop();
  }
}