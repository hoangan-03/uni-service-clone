import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base_v2/base/data/remote/interceptor/header_interceptor.dart';
import 'package:flutter_base_v2/base/data/remote/interceptor/log_interceptor.dart';
import 'package:flutter_base_v2/base/data/remote/interceptor/token_interceptor.dart';

enum DioBulderType { withToken, ignoredToken, refresh }

class DioBuilder extends DioMixin implements Dio {
  final String contentType = 'application/json';
  final int connectionTimeOutMls = 30000;
  final int readTimeOutMls = 30000;
  final int writeTimeOutMls = 30000;

   DioBuilder(
      {bool ignoredToken = false,
      required BaseOptions options,
      Dio? dioRefresh}) {
    options = BaseOptions(
      baseUrl: options.baseUrl,
      contentType: contentType,
      connectTimeout: Duration(milliseconds: connectionTimeOutMls),
      receiveTimeout: Duration(milliseconds: readTimeOutMls),
      sendTimeout: Duration(milliseconds: writeTimeOutMls),
    );

    this.options = options;

    interceptors.add(HeaderInterceptor());
    
    if (!ignoredToken && dioRefresh != null) {
      interceptors.add(TokenInterceptor(dioRefresh));
    }
    if (kDebugMode) {
      interceptors.add(
        CustomLogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          maxWidth: 100,
        ),
      );
    }

    httpClientAdapter = IOHttpClientAdapter();
  }
}
