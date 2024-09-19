import 'dart:convert';
import 'dart:io';

import 'package:app/service/network_manager_interface.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkManager implements INetworkManager {
  Future<ImageProvider> uploadImage(String uri, File image) {
    Future<StreamedResponse> response = _makeHttpRequest(uri, image);
    Future<String> uuid = _getUuidFromJson(response);
    return _getImage(uri, uuid);
  }

  Future<StreamedResponse> _makeHttpRequest(String uri, File image) async {
    var request = MultipartRequest('POST', Uri.parse("${uri}uploadfile/"));
    request.files.add(MultipartFile.fromBytes(
        'image', File(image.path).readAsBytesSync(), filename: image.path)
    );
    return await request.send();
  }

  Future<String> _getUuidFromJson(Future<StreamedResponse> response) async {
    StreamedResponse resp = await response;
    String body = (await Response.fromStream(resp)).body;
    var json = jsonDecode(body);
    String uuid = json["predictions"]["uuid"];
    return Future.value(uuid);
  }

  Future<ImageProvider> _getImage(String uri, Future<String> uuid) async {
    var response = await get(Uri.parse("${uri}get-image/${await uuid}"));
    return Image
        .memory(response.bodyBytes)
        .image;
  }
}
