import 'dart:convert';
import 'dart:io';

import 'package:app/entity/settings.dart';
import 'package:app/service/network_manager/network_manager_interface.dart';
import 'package:app/service/settings_database.dart';
import 'package:http/http.dart';

import '../../entity/detection/result.dart';
import '../../service/network_manager/network_manager.dart';

class ResponseImagePresenter {
  final INetworkManager networkManager = NetworkManager();
  SettingsDatabase settingsDatabase = SettingsDatabase();

  Future<StreamedResponse> saveImage(Result result, File image) async {
    String json = jsonEncode(result);
    String uri = await _getStorageIpUri();
    return networkManager.saveImage(uri, image, json);
  }

  Future<String> _getStorageIpUri() async {
    Settings settings = await settingsDatabase.getLastAddress();
    return settings.storageIp;
  }
}
