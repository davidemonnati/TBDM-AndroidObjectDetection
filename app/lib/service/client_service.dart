import 'dart:io';

import 'package:http/http.dart';

void makeHttpRequest(File image) async {
  var uri = "http://192.168.1.132:8000/uploadfile/";
  var request = MultipartRequest('POST', Uri.parse(uri));
  request.files.add(MultipartFile.fromBytes(
      'image', File(image.path).readAsBytesSync(), filename: image.path)
  );
  var response = await request.send();
}