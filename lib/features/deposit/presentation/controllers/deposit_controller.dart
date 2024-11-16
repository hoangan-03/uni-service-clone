import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/deposit/data/models/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/domain/usecases/deposit_uc.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DepositController extends BaseController<DepositInput> {
  DepositRequestUseCase get _depositRequestUseCase =>
      Get.find<DepositRequestUseCase>();
  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  var isBalanceVisible = false.obs;
    // Amount controller and observable for deposit amount
  final amountController = TextEditingController();
  var amount = ''.obs;

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
    // Function to add a preset amount to the current amount
  void addAmount(String amountToAdd) {
    int currentAmount = int.tryParse(amount.value.replaceAll('.', '')) ?? 0;
    int addAmount = int.tryParse(amountToAdd.replaceAll('.', '')) ?? 0;
    int newAmount = currentAmount + addAmount;

    // Format the new amount as currency and update
    amount.value = NumberFormat("#,###", "vi_VN").format(newAmount);
    amountController.text = amount.value; // Update the TextField controller
  }

  // Function to update the amount based on direct input
  void updateAmount(String value) {
    amount.value = value;
  }

  // Function to clear the amount
  void clearAmount() {
    amountController.clear();
    amount.value = '';
  }

  Future<void> depositRequest(int price) async {
    final params = DepositRequest(
      price: price,
    );
    try {
      await _depositRequestUseCase.build(params);
      print("Topup successfully.");
    } catch (e) {
      print("Failed to topup: $e");
    }
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
