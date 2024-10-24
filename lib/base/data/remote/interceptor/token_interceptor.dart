import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/utils/config/app_config.dart';
import 'package:get/instance_manager.dart';
import '../../local/local_storage.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final _authHeaderKey = 'Authorization';
  final _bearer = 'Bearer';
  final _refreshTokenUrl = '${AppConfig.baseUrl}/api/v1/auth/refresh';
  final _accessTokenKey = 'access_token';
  final _refreshTokenKey = 'refresh_token';

  final _localStorage = Get.find<LocalStorage>();


  TokenInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    print("onRequest TokenInterceptor ${options.uri}");
    final localToken = await _localStorage.accessToken ?? '';
    if (localToken.isNotEmpty) {
      options.headers[_authHeaderKey] = '$_bearer $localToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
  
    print("onRequest TokenInterceptor ${err.requestOptions.uri}");
    final error = err.error;
    if (error is AppException) {
      handler.next(err);
    } else if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        final requestOptions = err.requestOptions;
        final requestToken = requestOptions.headers[_authHeaderKey] ?? '';
        final localToken = await _localStorage.accessToken ?? '';
        if ((requestToken == '$_bearer $localToken')) {
          final localRefreshToken = await _localStorage.refreshToken ?? '';
          final Response response = await _dio.post(_refreshTokenUrl,
              data: {_refreshTokenKey: localRefreshToken},
              options: Options(responseType: ResponseType.json));
          final responseObject = response.data['data'];
          await _localStorage.saveAccessToken(responseObject[_accessTokenKey]);
          await _localStorage
              .saveUserRefreshToken(responseObject[_refreshTokenKey]);
        }
        // Update header
        final newLocalToken = await _localStorage.accessToken ?? '';
        var newRequestToken = '$_bearer $newLocalToken';
        requestOptions.headers.update(_authHeaderKey, (_) => newRequestToken,
            ifAbsent: () => newRequestToken);
        // Re-call request
        final Response response = await recallOriginalApi(requestOptions);
        return handler.resolve(response);
      } on DioException catch (_) {
        handler.next(err);
      }
    } 
    else {
      handler.next(err);
    }
  }

  Future<Response> recallOriginalApi(RequestOptions options) {
    return _dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      cancelToken: options.cancelToken,
      options: Options(
        method: options.method,
        sendTimeout: options.sendTimeout,
        extra: options.extra,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
        requestEncoder: options.requestEncoder,
        responseDecoder: options.responseDecoder,
        listFormat: options.listFormat,
      ),
      onReceiveProgress: options.onReceiveProgress,
    );
  }

}
