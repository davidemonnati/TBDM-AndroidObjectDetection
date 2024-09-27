import 'dart:io';

import 'package:app/entity/result.dart';
import 'package:flutter/cupertino.dart';

abstract class INetworkManager {
  Future<Result> uploadImage(String uri, File image);

  Future<ImageProvider> getElaboratedImage(Result result);
}