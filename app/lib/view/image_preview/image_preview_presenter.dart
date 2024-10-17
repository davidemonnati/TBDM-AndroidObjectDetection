import 'dart:io';

import 'package:app/entity/detection/result.dart';
import 'package:app/entity/settings.dart';
import 'package:app/service/network_manager/network_manager_interface.dart';
import 'package:app/service/settings_database.dart';
import 'package:camera/camera.dart';

import '../../service/network_manager/network_manager.dart';

class ImagePreviewPresenter {
  final INetworkManager _networkManager = NetworkManager();
  final SettingsDatabase settingsDatabase = SettingsDatabase();

  Future<Result> uploadImage(XFile image) async {
    File imageToUpload = File(image.path);
    String uri = await _getDetectionIpUri();
    return await _networkManager.uploadImage(uri, imageToUpload);
  }

  Future<File> getElaboratedImage(Result result) async {
    String uri = await _getDetectionIpUri();
    return _networkManager.getElaboratedImage(uri, result);
  }

  Future<String> _getDetectionIpUri() async {
    Settings settings = await settingsDatabase.getLastAddress();
    return settings.detectionIp;
  }
}
