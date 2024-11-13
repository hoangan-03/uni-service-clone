import 'dart:async';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:notification_center/notification_center.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:permission_handler/permission_handler.dart';

class QrcodeController extends BaseController<HomeInput> {
  final pushNotiService = Get.find<PushNotificationService>();
  final NotificationCenter _notificationCenter = NotificationCenter();
  final scanerController = ScanController();
  QRViewController? qrController;
  final isAllowCameraPermission = false.obs;

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

  void scannedQRCode(String productId) {
    // try {
    //   _notificationCenter.notify('scannedQRCode', data: qrCodeBase64);
    // } catch (e) {
    //   _notificationCenter.notify('scannedQRCodpre', data: qrCodeBase64);
    // }
  }

  Future onQRViewCreated(QRViewController controller) async {
    qrController = controller;
    await controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      var qrCode = scanData.code;
      if (qrCode != null) {
        controller.pauseCamera();
        scannedQRCode(qrCode);
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
    N.toHome(input: HomeInput("", ""));
  }
}