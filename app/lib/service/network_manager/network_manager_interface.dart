import 'dart:io';

import 'package:app/entity/detection/result.dart';
import 'package:http/http.dart';

abstract class INetworkManager {
  Future<Result> uploadImage(String uri, File image);

  Future<File> getElaboratedImage(String uri, Result result);

  Future<StreamedResponse> saveImage(String uri, File image, String json);
}