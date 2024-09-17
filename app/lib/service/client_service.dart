import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

var uri = "http://192.168.1.32:8000/";

Future<ImageProvider> uploadImage(File image) {
  Future<StreamedResponse> response = makeHttpRequest(image);
  Future<String> uuid = getUuidFromJson(response);
  return getImage(uuid);
}

Future<StreamedResponse> makeHttpRequest(File image) async {
  var request = MultipartRequest('POST', Uri.parse("${uri}uploadfile/"));
  request.files.add(MultipartFile.fromBytes(
      'image', File(image.path).readAsBytesSync(), filename: image.path)
  );
  return await request.send();
}

Future<String> getUuidFromJson(Future<StreamedResponse> response) async {
  StreamedResponse resp = await response;
  String body = (await Response.fromStream(resp)).body;
  var json = jsonDecode(body);
  String uuid = json["predictions"]["uuid"];
  return Future.value(uuid);
}

Future<ImageProvider> getImage(Future<String> uuid) async {
  var response = await get(Uri.parse("${uri}get-image/${await uuid}"));
  return Image
      .memory(response.bodyBytes)
      .image;
}
