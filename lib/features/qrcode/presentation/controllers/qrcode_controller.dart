import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_avatar.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_profile_uc.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:notification_center/notification_center.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

class QrcodeController extends BaseController<HomeInput> {
  GetProfileUseCase get _getProfileUseCase => Get.find<GetProfileUseCase>();
  UpdateProfileUseCase get _updateProfileUseCase => Get.find<UpdateProfileUseCase>();
  UpdateAvatarUseCase get _updateAvatarUseCase => Get.find<UpdateAvatarUseCase>();
  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  final LocalStorage _localStorage = Get.find();

  final NotificationCenter _notificationCenter = NotificationCenter();
  final scanerController = ScanController();
  QRViewController? qrController;
  final recentMedium = Rxn<Medium?>();
  final isAllowCameraPermission = false.obs;

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();
    getProfile();
    _requestPermission();

    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  @override
  void onResumed() async {
    super.onResumed();
    if (await Permission.photos.isGranted) {
      _updateThumnailPhoto();
    }
  }

  @override
  void onClose() {
    pushNotiService.cancelNotification();
    _getProfileUseCase.dispose();
    _updateProfileUseCase.dispose();
    qrController?.dispose();
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

  Future<void> updateProfile(User updatedUser) {
    return _updateProfileUseCase.execute(
        observer: Observer(
          onSuccess: (_) {
            L.info("Profile updated successfully");
            user.value = updatedUser;
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: updatedUser);
  }

  Future<void> updateAvatar(File avatar) {
    return _updateAvatarUseCase.execute(
        observer: Observer(
          onSuccess: (_) {
            L.info("Avatar updated successfully");
            getProfile();
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: avatar);
  }

  Future openGallery() async {
    if (await Permission.photos.isGranted == true) {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery).onError((error, stackTrace) => null);
      
      if (file != null) {
        String? qrCode = await Scan.parse(file.path);
        if (qrCode != null) {
          scannedQRCode(qrCode);
        } else {
          showOkDialog(title: 'Error', message: 'Invalid QR code');
        }
      }
    }
  }

  void scannedQRCode(String qrCodeBase64) {
    try {
      _notificationCenter.notify('scannedQRCode', data: qrCodeBase64);
      Get.back();
    } catch (e) {
      _notificationCenter.notify('scannedQRCode', data: qrCodeBase64);
      Get.back();
    }
  }

  void _updateThumnailPhoto() async {
    List<Album> imageAlbums = await PhotoGallery.listAlbums();

    final MediaPage? imagePage = await imageAlbums.firstOrNull?.listMedia();
    if (imagePage != null) {
      final List<Medium> allMedia = [...imagePage.items];
      recentMedium.value = allMedia.firstOrNull;
    }
  }

  Future onQRViewCreated(QRViewController controller) async {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      var qrCode = scanData.code;
      if (qrCode != null) {
        controller.pauseCamera();
        scannedQRCode(qrCode);
      }
    });
  }

  Future _requestPermission() async {
    final isCameraGranted = await Permission.camera.isGranted;
    if (isCameraGranted != true) {
      isAllowCameraPermission.value =
          await Permission.camera.request().isGranted;
    } else {
      isAllowCameraPermission.value = isCameraGranted;
    }
    _promptPermissionPhotos();
  }

  _promptPermissionPhotos() async {
    if (Platform.isIOS) {
      final isPhotoGranted = await Permission.photos.isGranted;
      if(isPhotoGranted != true){
       if(await Permission.photos.request().isGranted) {
          _updateThumnailPhoto();
       }
      }
      else{
        _updateThumnailPhoto();
      }
    } else if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        if (await Permission.storage.request().isGranted) {
          _updateThumnailPhoto();
        }
      } else {
        if (await Permission.photos.request().isGranted) {
          _updateThumnailPhoto();
        }
      }
    }
    return false;
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

  void closeScanQR() {
    Get.back();
  }
}