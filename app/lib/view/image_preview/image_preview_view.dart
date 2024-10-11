import 'dart:io';
import 'package:app/view/image_preview/image_preview_presenter.dart';
import 'package:app/view/response_image/response_image_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../util/constants.dart';

class ImagePreviewView extends StatefulWidget {
  const ImagePreviewView({super.key, required XFile image}) : _image = image;
  final XFile _image;

  State<ImagePreviewView> createState() => _ImagePreviewViewState(image: _image);
}

class _ImagePreviewViewState extends State<ImagePreviewView> {
  _ImagePreviewViewState({required XFile image}) : _image = image;

  final XFile _image;
  static bool _loading = false;
  final ImagePreviewPresenter _presenter = ImagePreviewPresenter();

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
                  Container(
                    padding: MediaQuery
                        .of(context)
                        .padding * 1.2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Icon(
                              Icons.settings,
                              color: Constants.lightIconsColor,
                              size: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.07
                          )
                      ),
                    ],
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
                    child: InteractiveViewer(
                        panEnabled: true,
                        boundaryMargin: const EdgeInsets.all(100),
                        maxScale: 3,
                        child: Image.file(File(_image.path))
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
                                Constants.lightIconsColor, Icons.delete_outline,
                                'Cancel',
                                _deleteImage),
                          ),
                          Expanded(
                              child: _buildButtons(
                                  Constants.lightIconsColor,
                                  Icons.send_outlined,
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
                            child: Text(
                              "Processing",
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.w500,
                                color: Constants.lightIconsColor,
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
    _presenter.uploadImage(_image).then((result) async {
      File imageProvider = await _presenter.getElaboratedImage(result);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
              ResponseImageView(result: result, image: imageProvider)
          )
      );
      setState(() => _loading = false);
    }).catchError((error) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error.toString()),
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
