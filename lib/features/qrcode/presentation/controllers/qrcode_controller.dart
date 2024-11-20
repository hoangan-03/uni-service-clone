import 'dart:async';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/order/order_qr.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_qr_code.dart';
import 'package:flutter_base_v2/features/transfer/data/models/transfer_request.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer.dart';
import 'package:flutter_base_v2/features/transfer/domain/entities/transfer_detail.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_detail_uc.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:flutter_base_v2/features/transfer/presentation/views/transfer_bill.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:permission_handler/permission_handler.dart';

class QrcodeController extends BaseController<HomeInput> {
  final pushNotiService = Get.find<PushNotificationService>();
  final scanerController = ScanController();
  QRViewController? qrController;
  final isAllowCameraPermission = false.obs;
  final qrmenu = MenuQR().obs;

  var amount = "30000".obs;
  GetQrCodeUseCase get _getQrCodeUseCase => Get.find<GetQrCodeUseCase>();
  TransferRequestUseCase get _transferRequestUseCase =>
      Get.find<TransferRequestUseCase>();
  TransferDetailUseCase get _transferDetailUseCase =>
      Get.find<TransferDetailUseCase>();

  @override
  void onInit() async {
    super.onInit();
    await requestPermission();
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
    qrController?.dispose();
    super.onClose();
  }

  void scannedQRCode(String productId) async {
    try {
      final item = await getQrCode(productId);
      if (item != null) {
        Get.to(() => OrderQRPage(
              item: item,
              quantity: 1,
              itemIndex: 0,
            ));
      }
    } catch (e) {
      print("Failed to get item: $e");
    }
  }

  void scannedUserQRCode(String recipientId, String amount) async {
    try {
      final transferResponse = await transferRequest(recipientId, amount);
      if (transferResponse != null) {
        final transferDetail =
            await getTransferDetail(transferResponse.txn?? "");
        if (transferDetail != null) {
          Get.to(() => TransferBillPage(
                recipientName: transferDetail.recipient.username ?? "",
                phone: transferDetail.recipient.phone ?? "",
                amount: amount,
              ));
        }
      }
    } catch (e) {
      print("Failed to get transfer detail: $e");
    }
  }

  Future<Transfer?> transferRequest(String recipientId, String amount) async {
    final completer = Completer<Transfer?>();
    _transferRequestUseCase.execute(
      observer: Observer(
        onSuccess: (Transfer? transferResponse) {
          L.info(transferResponse);
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
          L.info(transferDetail);
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

  Future<MenuQR?> getQrCode(String productId) async {
    final completer = Completer<MenuQR?>();
    _getQrCodeUseCase.execute(
      observer: Observer(
        onSuccess: (MenuQR? qrMenu) {
          L.info(qrMenu);
          completer.complete(qrMenu);
        },
        onError: (AppException e) {
          handleError(e);
          completer.completeError(e);
        },
      ),
      input: GetQrCodeParams(productId: productId),
    );
    return completer.future;
  }

  Future onQRViewCreated(QRViewController controller) async {
    qrController = controller;
    await controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      var qrCode = scanData.code;
      if (qrCode != null) {
        controller.pauseCamera();
        if (qrCode.startsWith("usr:")) {
          var recipientId = qrCode.substring(4);
          scannedUserQRCode(recipientId, amount.value);
        } else {
          scannedQRCode(qrCode);
        }
        closeScanQR();
      }
    });
  }

  Future requestPermission() async {
    final isCameraGranted = await Permission.camera.isGranted;
    if (isCameraGranted != true) {
      isAllowCameraPermission.value =
          await Permission.camera.request().isGranted;
    } else {
      isAllowCameraPermission.value = isCameraGranted;
    }
  }

  void closeScanQR() {
    qrController?.pauseCamera();
    qrController?.dispose();
    Get.delete<QrcodeController>();
    N.toHome(input: HomeInput(''));
  }
}
