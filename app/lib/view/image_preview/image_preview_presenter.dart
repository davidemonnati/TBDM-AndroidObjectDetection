import 'dart:io';

import 'package:app/entity/detection/result.dart';
import 'package:app/util/constants.dart';
import 'package:camera/camera.dart';

import '../../service/network_manager.dart';
import '../../service/network_manager_interface.dart';

class ImagePreviewPresenter {
  final INetworkManager _networkManager = NetworkManager();

  Future<Result> uploadImage(XFile image) async {
    File imageToUpload = File(image.path);
    return await _networkManager.uploadImage(Constants.uri, imageToUpload);
  }

  Future<File> getElaboratedImage(Result result) async {
    return _networkManager.getElaboratedImage(result);
  }
}