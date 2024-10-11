import 'dart:io';
import 'dart:math';

import 'package:app/entity/result.dart';
import 'package:app/view/response_image/response_image_presenter.dart';
import 'package:flutter/material.dart';

import '../../util/constants.dart';

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

  //final INetworkManager networkManager = NetworkManager();
  final ResponseImagePresenter _responseImagePresenter = ResponseImagePresenter();
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
            Stack(
              children: [
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .width * 0.3,
                  child: RichText(
                      text: TextSpan(
                          text: 'Preview',
                          style: TextStyle(
                            fontSize: 36,
                            fontFamily: 'cabin',
                            color: Constants.lightIconsColor,
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
                                Constants.lightIconsColor,
                                Icons.delete_outlined, 'Delete',
                                _deleteImage)
                        ),
                        Expanded(
                            child: _buildButtons(
                                Constants.lightIconsColor,
                                Icons.archive_outlined, 'Save',
                                _saveImage)
                        ),
                      ],
                    )
                ),
              ],
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
                              "Saving",
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

    _responseImagePresenter.saveImage(_result, _image).then((result) {
      setState(() => _loading = false);
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              _showDialog()
      );
    }).onError((e, s) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text(
                  "An error has occurred"),
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

  Widget _showDialog() {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 5),
            const Text('Image successfully saved'),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
