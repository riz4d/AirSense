import 'package:airsens/core/error_handling/failure.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

Failure handleError({required Object error}) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(errMSg: "Connection timeout error");
      case DioExceptionType.sendTimeout:
        return Failure(errMSg: "Send timeout error");
      case DioExceptionType.receiveTimeout:
        return Failure(errMSg: "Receive timeout error");
      case DioExceptionType.badResponse:
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          printErrorDetails(error);
          return Failure(
            errMSg: error.response.toString(),
          );
        } else {
          return Failure(errMSg: "Bad response error");
        }
      case DioExceptionType.cancel:
        return Failure(errMSg: "Request cancelled");
      default:
        return Failure(errMSg: "Unexpected error");
    }
  } else {
    return Failure(
      errMSg: error.toString(),
    );
  }
}

void printErrorDetails(dynamic error) {
  try {
    if (error.response?.data != null) {
      // Destructure the error data

      final errors = error.response?.data['errors'] ?? [];

      // Check if there are any errors
      if (errors.isNotEmpty) {
        for (var errorDetail in errors) {
          final message = errorDetail['message'];
          final code = errorDetail['extensions']?['code'];

          // Print the error message and code
          print("==================================================");
          print('Error Message: $message');
          print('Error Code: $code');
          print("==================================================");
        }
      } else {
        print('No errors found.');
      }
    } else {
      print('Error response is null.');
    }
  } catch (e) {
    print("ERROR WHILE PRINTING ERRORS");
  }
}

void logError(dynamic error) {
  Logger().t(error.toString());
}
