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

  @override void initState() {
    loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.1,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                //alignment: Alignment.topLeft,
                padding: MediaQuery
                    .of(context)
                    .padding * 1.2,
                child: RichText(
                    text: const TextSpan(
                        text: 'New image',
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'cabin',
                        )
                    )
                ),
              ),
              Container(
                padding: MediaQuery
                    .of(context)
                    .padding * 0.5,
                child: Image.file(File(image.path)),
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SizedBox(height: MediaQuery
                  //     .of(context)
                  //     .size
                  //     .height * 0.2,),
                  Expanded(
                    child: _buildButtons(
                        Colors.white, Icons.delete, 'Cancel', deleteImage),
                  ),
                  Expanded(
                      child: _buildButtons(
                          Colors.white, Icons.send, 'Elaborate', elaborateImage)
                  )
                ],
              )
            ]
        )
    );
  }

  Column _buildButtons(Color color, IconData icon, String label,
      Function() funzione) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: () => funzione(),
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

  void elaborateImage() {
    setState(() => loading = true);
    uploadImage(File(image.path)).then((image) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ResponseView(image: image))
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
          ));
    });
  }

  void deleteImage() {
    Navigator.of(context).pop();
  }
}

