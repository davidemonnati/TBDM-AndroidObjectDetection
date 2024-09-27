import 'dart:convert';
import 'dart:io';

import 'package:app/entity/result.dart';
import 'package:app/service/network_manager_interface.dart';
import 'package:app/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkManager implements INetworkManager {

  @override
  Future<Result> uploadImage(String uri, File image) {
    Future<StreamedResponse> response = _makeHttpRequest(uri, image);
    return _getResultFromResponse(response);
  }

  @override
  Future<ImageProvider> getElaboratedImage(Result result) {
    String uuid = result.uuid;
    return _getImage(Constants.uri, uuid);
  }

  Future<StreamedResponse> _makeHttpRequest(String uri, File image) async {
    var request = MultipartRequest('POST', Uri.parse("${uri}uploadfile/"));
    request.files.add(MultipartFile.fromBytes(
        'image', File(image.path).readAsBytesSync(), filename: image.path)
    );
    return await request.send();
  }

  Future<Result> _getResultFromResponse(
      Future<StreamedResponse> response) async {
    StreamedResponse resp = await response;
    String body = (await Response.fromStream(resp)).body;
    return Result.fromJson(jsonDecode(body)['predictions']);
  }

  Future<ImageProvider> _getImage(String uri, String uuid) async {
    var response = await get(Uri.parse("${uri}get-image/${await uuid}"));
    return Image
        .memory(response.bodyBytes)
        .image;
  }
}
