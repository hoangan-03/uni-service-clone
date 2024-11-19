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
import 'package:flutter_base_v2/features/deposit/data/models/deposit_request.dart';
import 'package:flutter_base_v2/features/deposit/domain/entities/deposit.dart';
import 'package:flutter_base_v2/features/deposit/domain/usecases/deposit_uc.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_input.dart';
import 'package:flutter_base_v2/features/deposit/presentation/views/webview_page.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
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
      final AccountController controller = Get.put(AccountController());

  final user = User().obs;
  var isBalanceVisible = false.obs;



  final amountController = TextEditingController();
  var currentAmount = ''.obs;
  var depositResponse = Deposit().obs;

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

  void setAmount(String amount) {
    currentAmount.value = NumberFormat("#,###", "vi_VN")
        .format(int.tryParse(amount.replaceAll('.', '')) ?? 0);
    amountController.text = currentAmount.value;
  }

  void updateAmount(String value) {
    currentAmount.value = value;
  }

  void clearAmount() {
    amountController.clear();
    currentAmount.value = '';
  }

  void onAmountChanged(String value) {
    String cleanedValue = value.replaceAll(RegExp(r'\D'), '');
    String formattedValue = formatPrice(int.tryParse(cleanedValue) ?? 0);
    amountController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
    updateAmount(formattedValue);
  }

  Future<void> depositRequest(int price) async {
    if (controller.user.value.school == null ||
        controller.user.value.faculty == null ||
        controller.user.value.identificationCard == null ||
        controller.user.value.position == null) {
      Get.snackbar(
        'Thiếu thông tin',
        'Hoàn thành các trường sau để tiếp tục: Trường, Khoa, CCCD, Chức vụ',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      await Future.delayed(Duration(seconds: 3));
      N.toAccountInfo();
      return;
    }

    final params = DepositRequest(
      price: price,
    );
    return _depositRequestUseCase.execute(
      observer: Observer(
        onSuccess: (Deposit? data) {
          L.info(data);
          if (data != null) depositResponse.value = data;
          Get.to(() => WebViewPage(url: data?.paymentURL ?? 'https://www.facebook.com/'));
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