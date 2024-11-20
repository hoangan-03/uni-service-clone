import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/deposit/domain/entities/deposit.dart';
import 'package:flutter_base_v2/features/deposit/domain/usecases/deposit_uc.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_detail_uc.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';

class TransferController extends BaseController<TransferInput> {
  DepositRequestUseCase get _depositRequestUseCase =>
      Get.find<DepositRequestUseCase>();
  TransferRequestUseCase get _transferRequestUseCase =>
      Get.find<TransferRequestUseCase>();
  TransferDetailUseCase get _transferDetailUseCase =>
      Get.find<TransferDetailUseCase>();

  final pushNotiService = Get.find<PushNotificationService>();

  final AccountController controller = Get.put(AccountController());

  final user = User().obs;

  var depositResponse = Deposit().obs;
  var transferResponse = Transfer().obs;

  final LocalStorage _localStorage = Get.find();

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();

    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  @override
  void onClose() {
    pushNotiService.cancelNotification();
    _depositRequestUseCase.dispose();
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

  Future<void> transferRequest(String recipientId, String amount) async {
    final params = TransferRequest(recipientId: recipientId, amount: amount);
    return _transferRequestUseCase.execute(
      observer: Observer(
        onSuccess: (Transfer? data) {
          L.info(data);
          if (data != null) transferResponse.value = data;
        },
        onError: (AppException e) {
          handleError(e);
        },
      ),
      input: params,
    );
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
