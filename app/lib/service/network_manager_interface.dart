import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class INetworkManager {
  Future<ImageProvider> uploadImage(String uri, File image);
}