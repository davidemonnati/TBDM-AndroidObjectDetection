import 'package:camera/camera.dart';

class HomePresenter {
  Future<XFile> takePicture(CameraController controller) async {
    return await controller.takePicture();
  }
}