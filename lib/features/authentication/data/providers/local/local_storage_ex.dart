import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_model.dart';

extension LocalStorageEx on LocalStorage {
  static const String _kAccessToken = 'access_token';

  static const String _kRefreshToken = 'refresh_token';

  static const String _kLocale = 'locale';

  static const String _kThemeMode = 'theme_mode';

  // User token
  Future<String?> get accessToken {
    return secureStorage.read(key: _kAccessToken);
  }

  Future<void> saveAccessToken(String? accessToken) {
    return secureStorage.write(key: _kAccessToken, value: accessToken);
  }

  Future<void> removeAccessToken() {
    return secureStorage.delete(key: _kAccessToken);
  }

  // User refresh token
  Future<String?> get refreshToken {
    return secureStorage.read(key: _kRefreshToken);
  }

  Future<void> saveUserRefreshToken(String? refreshToken) async {
    if (refreshToken == null) return;

    return secureStorage.write(key: _kRefreshToken, value: refreshToken);
  }

  Future<void> removeRefreshToken() {
    return secureStorage.delete(key: _kRefreshToken);
  }

  // User token data
  Future<void> saveUserTokenData(TokenModel? tokenModel) {
    return Future.wait([
      saveAccessToken(tokenModel?.accessToken),
      saveUserRefreshToken(tokenModel?.refreshToken),
    ]);
  }

  Future<void> removeUserTokenData() {
    return Future.wait([
      removeAccessToken(),
      removeRefreshToken(),
    ]);
  }

  // Locale
  String? get locale {
    return getStorage.read(_kLocale);
  }

  Future<void> saveLocale(String currentLocale) {
    return getStorage.write(_kLocale, currentLocale);
  }

  Future<void> removeLocale() {
    return getStorage.remove(_kLocale);
  }

  // Dark mode
  ThemeMode get themeMode {
    final String themeMode = getStorage.read(_kThemeMode) ?? 'system';

    return ThemeMode.values.byName(themeMode);
  }

  Future<void> saveThemeMode(ThemeMode themeMode) {
    return getStorage.write(_kThemeMode, themeMode.name);
  }

  Future<void> removeThemeMode() {
    return getStorage.remove(_kThemeMode);
  }
}
