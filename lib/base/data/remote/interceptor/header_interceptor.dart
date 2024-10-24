import 'dart:io';

import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:package_info_plus/package_info_plus.dart';


class HeaderInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    options.headers['App-Version'] = await appVersion();
    options.headers['Content-Type'] = 'application/json';
    options.headers['App-Os'] = deviceType();
    options.headers['language'] = 'vi';

    handler.next(options);
  }

  Future<String> appVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.version;
    } on Exception catch (_) {
      return 'The Platform not support get info';
    }
  }

  // Future<String?> deviceId() async {
  //   String? deviceId;
  //   if (Platform.isIOS) {
  //     deviceId = (await DeviceInfoPlugin().iosInfo).identifierForVendor;
  //   } else if (Platform.isAndroid) {
  //     deviceId = await const AndroidId().getId();
  //   }

  //   return deviceId;
  // }

  String deviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    }

    return 'unknown';
  }
}
