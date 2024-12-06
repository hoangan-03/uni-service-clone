import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
class LocalStorage {
  final _getStorage = GetStorage();
  final _secureStorage = const FlutterSecureStorage();

  GetStorage get getStorage => _getStorage;
  FlutterSecureStorage get secureStorage => _secureStorage;

  Future<void> setString(String key, String value) async {
    await _getStorage.write(key, value);
  }

  Future<String?> getString(String key) async {
    return _getStorage.read(key);
  }

  Future<void> remove(String key) async {
    await _getStorage.remove(key);
  }

  Future<void> removeAllData() async {
    L.info('Remove all data');
    final localStorage = Get.find<LocalStorage>();
    final locale = localStorage.locale;
    final themeMode = localStorage.themeMode;

    await Future.wait([
      _getStorage.erase(),
      _secureStorage.deleteAll(),
    ]);
    
    if (locale != null) {
      await Future.wait([
        localStorage.saveLocale(locale),
        localStorage.saveThemeMode(themeMode),
      ]);
    }
  }
}


class LocaleController extends GetxController {
  final LocalStorage _localStorage = Get.find();

  void changeLocale(Locale locale) {
    Get.updateLocale(locale);
    _localStorage.saveLocale(locale.languageCode);
  }
}