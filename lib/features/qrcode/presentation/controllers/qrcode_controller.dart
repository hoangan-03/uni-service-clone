import 'dart:async';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/order/order_qr.dart';
import 'package:flutter_base_v2/features/order/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_qr_code.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/features/transfer/presentation/views/transfer.dart';
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

  var amount = 30000.obs;
  GetQrCodeUseCase get _getQrCodeUseCase => Get.find<GetQrCodeUseCase>();
  final TransferController transferController = Get.put(TransferController());

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
      print("something") ;
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

  Future<MenuQR?> getQrCode(String productId) async {
    final completer = Completer<MenuQR?>();
    _getQrCodeUseCase.execute(
      observer: Observer(
        onSuccess: (MenuQR? qrMenu) {
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
          Get.to(() => TransferPage(recipientId: recipientId))!.then((_) {
            closeScanQR();
          });
        } else {
          scannedQRCode(qrCode);
          closeScanQR();
        }
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
