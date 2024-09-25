import 'dart:io';
import 'package:app/view/image_preview/image_preview_presenter.dart';
import 'package:app/view/response_image/response_image_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagePreviewView extends StatefulWidget {
  const ImagePreviewView({super.key, required XFile image}) : _image = image;
  final XFile _image;

  State<ImagePreviewView> createState() => _ImagePreviewViewState(image: _image);
}

class _ImagePreviewViewState extends State<ImagePreviewView> {
  _ImagePreviewViewState({required XFile image}) : _image = image;

  final XFile _image;
  static bool _loading = false;
  ImagePreviewPresenter _presenter = ImagePreviewPresenter();

  @override void initState() {
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Stack(
                children: [
                  Positioned(
                      top: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      child: RichText(
                          text: const TextSpan(
                              text: 'New image',
                              style: TextStyle(
                                fontSize: 36,
                                fontFamily: 'cabin',
                              )
                          )
                      )
                  ),
                  Positioned(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: 0.7,
                      child: Image.file(File(_image.path)),
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
                                Colors.white, Icons.delete_outline, 'Cancel',
                                _deleteImage),
                          ),
                          Expanded(
                              child: _buildButtons(
                                  Colors.white, Icons.send_outlined,
                                  'Elaborate',
                                  _elaborateImage)
                          ),
                        ],
                      )
                  ),
                ]
            ),
            Visibility(
                visible: _loading,
                child: Positioned(
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(strokeWidth: 5),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: const Text(
                              "Processing",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                )
            ),
          ],
        )

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

  void _elaborateImage() {
    setState(() => _loading = true);
    _presenter.uploadImage(_image).then((image) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ResponseImageView(image: image))
      );
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
    Navigator.of(context).pop();
  }
}
