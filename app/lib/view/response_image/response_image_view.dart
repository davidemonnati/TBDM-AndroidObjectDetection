import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app/entity/result.dart';
import 'package:app/service/network_manager.dart';
import 'package:app/service/network_manager_interface.dart';
import 'package:flutter/material.dart';

class ResponseImageView extends StatefulWidget {
  const ResponseImageView({super.key, required Result result, required File image}) :
        _image = image,
        _result = result;

  final File _image;
  final Result _result;

  State<ResponseImageView> createState() => _ResponseImageViewState(image: _image, result: _result);
}

class _ResponseImageViewState extends State<ResponseImageView> {
  final File _image;
  final Result _result;
  final INetworkManager networkManager = NetworkManager();
  static bool _loading = false;

  _ResponseImageViewState({required File image, required Result result})
      : _image = image,
        _result = result;

  @override void initState() {
    _loading = false;
    super.initState();
  }

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
                  child: Image(
                      image: Image
                          .memory(_image.readAsBytesSync())
                          .image
                  ),
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
                            _deleteImage)
                    ),
                    Expanded(
                        child: _buildButtons(
                            Colors.white, Icons.archive_outlined, 'Save',
                            _saveImage)
                    ),
                  ],
                )
            ),
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

  void _saveImage() {
    setState(() => _loading = true);
    var json = jsonEncode(_result.toJson());

    networkManager.saveImage(_image, json).then((result) {
      setState(() => _loading = false);
    }).onError((e, s) {
      setState(() => _loading = false);
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

  void _deleteImage() {
    Navigator.pushNamed(context, '/home');
  }
}