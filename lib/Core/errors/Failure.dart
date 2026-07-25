import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioExcepiton(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'connction timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'send Timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'receive Timeout');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'bad Certificate');

      case DioExceptionType.cancel:
        return ServerFailure(errMessage: 'Request to ApiServer was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'Connection Error');

      default:
        return ServerFailure(errMessage: 'OPS there was an error');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode >= 400 && statusCode < 500) {
      return ServerFailure(
        errMessage: response['message'] ?? " UnKnown Error , please try later",
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errMessage: 'Internal Server fialure , please try later',
      );
    } else {
      return ServerFailure(
        errMessage: 'OPS there was error , status code statusCode',
      );
    }
  }
}
