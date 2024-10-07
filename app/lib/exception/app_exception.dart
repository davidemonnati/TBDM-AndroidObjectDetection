import 'package:app/exception/app_error.dart';

class AppException implements Exception {
  AppError appError;

  AppException(this.appError);

  @override
  String toString() {
    return appError.message;
  }
}