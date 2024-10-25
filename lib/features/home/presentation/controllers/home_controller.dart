import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/home/domain/entities/user.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/home/domain/usecases/profile/get_profile_uc.dart';
import 'package:flutter_base_v2/features/home/domain/usecases/branch/get_branch_uc.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';

class HomeController extends BaseController<HomeInput> {
  GetProfileUseCase get _getProfileUseCase => Get.find<GetProfileUseCase>();
  GetBranchUseCase get _getBranchUseCase => Get.find<GetBranchUseCase>();

  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  final branches = <Branch>[].obs;
  final LocalStorage _localStorage = Get.find();

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();
    getProfile();
    getBranches();
    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  @override
  void onClose() {
    pushNotiService.cancelNotification();
    _getProfileUseCase.dispose();
    _getBranchUseCase.dispose();
    super.onClose();
  }

  void showNotifications() {
    pushNotiService.showLocalNotification(
        title: "Demo notifications", body: 'Demo body', payload: 'payload');
  }

  void printFcmToken() async {
    final fcmToken = await pushNotiService.fcmToken;
    L.debug(fcmToken);
  }

  void setAccessToken() {
    _localStorage.saveAccessToken('accessToken123123123');
  }

  void setRefreshToken() {
    _localStorage.saveUserRefreshToken('refreshToken123123123');
  }

  void clearAllData() {
    _localStorage.removeAllData();
  }

  Future<void> getProfile() {
    return _getProfileUseCase.execute(
        observer: Observer(
          onSuccess: (User? data) {
            L.info(data);
            if (data != null) user.value = data;
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: null);
  }

  Future<void> getBranches() {
    return _getBranchUseCase.execute(
        observer: Observer(
          onSuccess: (Branch? data) {
            L.info(data);
            if (data != null) branches.add(data);
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: null);
  }

  void logout() {
    Get.find<AuthService>().logout();
  }

  void printIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();
    L.debug(imagePaths);
  }

  void switchTheme() {
    final newThemeMode = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _localStorage.saveThemeMode(newThemeMode);
    Get.changeThemeMode(newThemeMode);
  }
}