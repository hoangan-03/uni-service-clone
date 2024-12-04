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
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer_detail.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_detail_uc.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_input.dart';
import 'package:flutter_base_v2/features/transfer/presentation/views/transfer_bill.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransferController extends BaseController<TransferInput> {
  DepositRequestUseCase get _depositRequestUseCase =>
      Get.find<DepositRequestUseCase>();
  TransferRequestUseCase get _transferRequestUseCase =>
      Get.find<TransferRequestUseCase>();
  TransferDetailUseCase get _transferDetailUseCase =>
      Get.find<TransferDetailUseCase>();

  final pushNotiService = Get.find<PushNotificationService>();
  final amountController = TextEditingController();
  final AccountController controller = Get.put(AccountController());

  final user = User().obs;

  var currentAmount = ''.obs;

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

  Future<Transfer?> transferRequest(String recipientId, int amount) async {
    final completer = Completer<Transfer?>();
    _transferRequestUseCase.execute(
      observer: Observer(
        onSuccess: (Transfer? transferResponse) {
          completer.complete(transferResponse);
        },
        onError: (AppException e) {
          handleError(e);
          completer.completeError(e);
        },
      ),
      input: TransferRequest(recipientId: recipientId, amount: amount),
    );
    return completer.future;
  }

  Future<TransferDetail?> getTransferDetail(String txn) async {
    final completer = Completer<TransferDetail?>();
    _transferDetailUseCase.execute(
      observer: Observer(
        onSuccess: (TransferDetail? transferDetail) {
          completer.complete(transferDetail);
        },
        onError: (AppException e) {
          handleError(e);
          completer.completeError(e);
        },
      ),
      input: TransferDetailParams(txn: txn),
    );
    return completer.future;
  }

  void scannedUserQRCode(String recipientId, int amount) async {
    try {
      final transferResponse = await transferRequest(recipientId, amount);
      L.info("scannedUserQrcode");
      if (transferResponse != null) {
        final transferDetail =
            await getTransferDetail(transferResponse.txn ?? "");
        L.info("transferDetail");
        if (transferDetail != null) {
          Get.to(() => TransferBillPage(
                recipientName: transferDetail.recipient.username ?? "",
                phone: transferDetail.recipient.phone ?? "",
                amount: amount,
              ));
        }
      }
    } catch (e) {
      L.info("Failed to get transfer detail: $e");
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
