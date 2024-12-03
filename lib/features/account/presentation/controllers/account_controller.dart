import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_avatar.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_binding.dart';
import 'package:flutter_base_v2/features/account/presentation/views/account_info.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_input.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_profile_uc.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_base_v2/utils/service/push_notification_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountController extends BaseController<HomeInput> {
  GetProfileUseCase get _getProfileUseCase => Get.find<GetProfileUseCase>();
  UpdateProfileUseCase get _updateProfileUseCase =>
      Get.find<UpdateProfileUseCase>();
  UpdateAvatarUseCase get _updateAvatarUseCase =>
      Get.find<UpdateAvatarUseCase>();
  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  var isBalanceVisible = false.obs;
  var isFaceIdEnabled = false.obs;
  var isDarkModeEnabled = false.obs;
  final ImagePicker _picker = ImagePicker();

  final LocalStorage _localStorage = Get.find();

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();
    getProfile();
     isDarkModeEnabled.value = Get.isDarkMode;

    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  void navigateToDeposit() {
    final depositInput = DepositInput(user.value.point ?? 0);
    Get.toNamed('/deposit', arguments: depositInput);
  }

  void naviageToAccountInfo() {
    Get.to(() => const AccountInfoPage(), binding: AccountBinding());
  }

  void navigateToSettings() {
    N.toSettings();
  }

  void selectQrOption() {
    Get.back();
    N.toQrScanner();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      final formattedFile = File(image.path);
      updateAvatar(formattedFile);
      buildSnackBar("Cập nhật ảnh đại diện thành công", true);
    }
    Navigator.of(Get.context!).pop();
  }

  @override
  void onClose() {
    pushNotiService.cancelNotification();
    _getProfileUseCase.dispose();
    _updateProfileUseCase.dispose();
    super.onClose();
  }

  void showNotifications() {
    pushNotiService.showLocalNotification(
        title: "Demo notifications", body: 'Demo body', payload: 'payload');
  }

  void clearAllData() {
    _localStorage.removeAllData();
  }

  Future<void> getProfile() {
    return _getProfileUseCase.execute(
        observer: Observer(
          onSuccess: (User? data) {
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
            N.toAccount();
            getProfile();
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: avatar);
  }

  void reloadUserInfo() {
    getProfile();
  }

  void logout() {
    Get.find<AuthService>().logout();
    clearAllData();
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