import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app/entity/detection/result.dart';
import 'package:app/exception/app_error.dart';
import 'package:app/exception/app_exception.dart';
import 'package:app/service/network_manager_interface.dart';
import 'package:app/util/constants.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class NetworkManager implements INetworkManager {

  @override
  Future<Result> uploadImage(String uri, File image) {
    Future<StreamedResponse> response = _makeHttpRequest(uri, image)
        .catchError((error) {
      throw AppException(AppError.connectionNotAvailable);
    });
    return _getResultFromResponse(response);
  }

  @override
  Future<File> getElaboratedImage(Result result) {
    String uuid = result.uuid;
    return _getImage(Constants.uri, uuid);
  }

  @override
  Future<StreamedResponse> saveImage(File image, String json) async {
    var request = MultipartRequest(
        'POST', Uri.parse("${Constants.saveImageUri}app/image"));
    request.files.add(MultipartFile.fromBytes(
        'image',
        File(image.path).readAsBytesSync(),
        filename: image.path
            .split("/")
            .last
    ));
    request.fields['data'] = json;
    return await request.send();
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
    Result result;
    try {
      result = Result.fromJson(jsonDecode(body)['predictions']);
    } catch (exception) {
      throw AppException(AppError.elaborationFailed);
    }

    return result;
  }

  Future<File> _getImage(String uri, String uuid) async {
    var response = await get(Uri.parse("${uri}get-image/${await uuid}"));
    Uint8List uint8list = response.bodyBytes;
    ByteBuffer buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    Directory tempDir = await getTemporaryDirectory();
    return await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
    );
  }
}
