import 'dart:io';

import 'package:app/util/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import '../../service/network_manager.dart';
import '../../service/network_manager_interface.dart';

class ImagePreviewPresenter {
  final INetworkManager _networkManager = NetworkManager();

  Future<ImageProvider> uploadImage(XFile image) async {
    File imageToUpload = File(image.path);
    return _networkManager.uploadImage(Constants.uri, imageToUpload);
  }
}