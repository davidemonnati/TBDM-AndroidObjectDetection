import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../entity/result.dart';
import '../../service/network_manager.dart';
import '../../service/network_manager_interface.dart';

class ResponseImagePresenter {
  final INetworkManager networkManager = NetworkManager();

  Future<StreamedResponse> saveImage(Result result, File image) {
    String json = jsonEncode(result);
    return networkManager.saveImage(image, json);
  }
}