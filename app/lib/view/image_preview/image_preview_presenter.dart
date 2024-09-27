import 'dart:io';

import 'package:app/entity/result.dart';
import 'package:app/util/constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import '../../service/network_manager.dart';
import '../../service/network_manager_interface.dart';

class ImagePreviewPresenter {
  final INetworkManager _networkManager = NetworkManager();

  Future<Result> uploadImage(XFile image) async {
    File imageToUpload = File(image.path);
    return await _networkManager.uploadImage(Constants.uri, imageToUpload);
  }

  Future<ImageProvider> getElaboratedImage(Result result) async {
    String uri = Constants.uri;
    return _networkManager.getElaboratedImage(result);
  }
}