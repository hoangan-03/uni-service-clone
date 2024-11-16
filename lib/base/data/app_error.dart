import 'dart:io';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_v2/base/data/models/common/base_response.dart';

enum AppExceptionType {
  network,
  mapping,
  unauthorized,
  cancel,
  timeout,
  server,
  serverRetry,
  serverValidate,
  invalidInput,
  purchaseCancel,
  purchaseError,
  paymentRequired,
  updateInfoRequired,
  unknown, general,
}

class AppException {
  final AppExceptionType type;

  final String message;

  final dynamic error;

  final String? title;

  final BaseResponse? errorResponse;

  final int? headerCode;

  final StackTrace? stackTrace;

  // static Map<String, String> serverErrors = {};

  AppException(
    this.type,
    this.message, {
    this.error,
    this.title,
    this.errorResponse,
    this.headerCode,
    this.stackTrace,
  });

  factory AppException.invalidInput(String message) {
    return AppException(AppExceptionType.invalidInput, message);
  }

  factory AppException.fromException(Exception exception) {
    var type = AppExceptionType.unknown;
    var message = '';
    String? title;
    BaseResponse? errorResponse;
    int? headerCode;
    StackTrace? stackTrace;

    if (exception is DioException) {
      message = exception.response?.statusMessage ??
          exception.message ??
          'Unknown error';
      headerCode = exception.response?.statusCode ?? -1;

      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          type = AppExceptionType.timeout;
          message = 'Connection timeout';
          break;
        case DioExceptionType.sendTimeout:
          type = AppExceptionType.network;
          message = 'Connection timeout';
          break;
        case DioExceptionType.badResponse:
          switch (headerCode) {
            case HttpStatus.badRequest: // 400
              type = AppExceptionType.serverValidate;
              break;
            case HttpStatus.unauthorized: // 401
              type = AppExceptionType.unauthorized;
              break;
            case HttpStatus.paymentRequired: // 402
              type = AppExceptionType.paymentRequired;
              break;
            case HttpStatus.lengthRequired: // 411
              type = AppExceptionType.updateInfoRequired;
              break;
            default:
              type = AppExceptionType.server;
              break;
          }
          // Custom each project
          final response = exception.response;
          if (response != null) {
            try {
              errorResponse = JsonMapper.fromMap<BaseResponse>(response.data);
              message = errorResponse?.message ??
                  errorResponse?.code?.toString() ??
                  "";
              if (headerCode >= 500 &&
                  headerCode < 600 &&
                  errorResponse?.code == null) {
                message = 'Internal server error ($headerCode)';
              }
              if (errorResponse?.errors?.isNotEmpty == true) {
                message = "";
              }
            } catch (e) {
              return AppException(
                AppExceptionType.serverRetry,
                e.toString(),
                title: title,
                error: e,
                headerCode: headerCode,
                stackTrace: stackTrace,
              );
            }
          }
          break;
        case DioExceptionType.cancel:
          type = AppExceptionType.cancel;
          break;
        case DioExceptionType.unknown:
        default:
          if (exception.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = AppExceptionType.network;
            message = 'S.current.network_error';
          } else {
            type = AppExceptionType.unknown;
          }
          break;
      }
    } else {
      type = AppExceptionType.unknown;
      message = 'AppException: $exception';
    }

    return AppException(
      type,
      message,
      title: title,
      error: exception,
      errorResponse: errorResponse,
      headerCode: headerCode,
      stackTrace: stackTrace,
    );
  }

  factory AppException.fromError(Error error) {
    return AppException(
      AppExceptionType.unknown,
      'S.current.common_error_message',
      error: error,
      errorResponse: null,
      headerCode: null,
      stackTrace: error.stackTrace,
    );
  }

  @override
  String toString() {
    return '${type.name}: $message';
  }
}
