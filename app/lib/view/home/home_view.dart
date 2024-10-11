import 'package:app/util/constants.dart';
import 'package:app/view/home/home_presenter.dart';
import 'package:app/view/image_preview/image_preview_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => HomeView();
}

class HomeView extends State<MyHomePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late HomePresenter _presenter;

  @override
  void initState() {
    super.initState();

    _presenter = HomePresenter();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Icon(
                        Icons.settings,
                        color: Constants.lightIconsColor,
                        size: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07
                    )
                ),
              ]
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            ),
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.03,
            width: MediaQuery
                .of(context)
                .size
                .width,
          ),
          PreferredSize(
            preferredSize: const Size.fromHeight(10),
            child: TextButton(
              child: Icon(
                Icons.radio_button_checked,
                size: 80,
                color: Constants.lightIconsColor,
              ),
              onPressed: () async {
                XFile image = await _presenter.takePicture(_controller);
                _onPictureTaken(image);
              },
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onPictureTaken(XFile image) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ImagePreviewView(image: image))
    );
  }
}
