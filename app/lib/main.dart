import 'package:app/util/constants.dart';
import 'package:app/view/home/home_view.dart';
import 'package:app/view/settings/settings_view.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  final cameras = await availableCameras();

  final firstCamera = cameras.first;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(Constants.lightBackgroundColor),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => MyHomePage(camera: camera),
        '/settings': (context) => const SettingsView(),
      },
      home: MyHomePage(camera: camera),
    );
  }
}
