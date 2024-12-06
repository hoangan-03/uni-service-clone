import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/account/data/models/request/change_password_request.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_avatar.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_password_uc.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_input.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_profile_uc.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
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
  UpdatePasswordUseCase get _updatePasswordUseCase =>
      Get.find<UpdatePasswordUseCase>();
  UpdateAvatarUseCase get _updateAvatarUseCase =>
      Get.find<UpdateAvatarUseCase>();
  final pushNotiService = Get.find<PushNotificationService>();

  final user = User().obs;
  var isBalanceVisible = false.obs;
  var isFaceIdEnabled = false.obs;
  var isDarkModeEnabled = false.obs;
  final isHidePassword = true.obs;
  final ImagePicker _picker = ImagePicker();

  final LocalStorage _localStorage = Get.find();

  final pinController = TextEditingController();
  final focusNode = FocusNode();
  var pin = ''.obs;
  var isReType = false.obs;
  var isCheckOldPin = false.obs;
  var initialPin = ''.obs;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    pushNotiService.listenNotification();
    getProfile();
    isDarkModeEnabled.value = Get.isDarkMode;

    pinController.addListener(onPinCreated);
    pinController.addListener(onPinModified);

    final notificationAppLaunchDetails =
        await pushNotiService.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      N.toNotifications();
    }
  }

  void onTapEye() {
    isHidePassword.value = !isHidePassword.value;
  }

  void onPinCreated() {
    pin.value = pinController.text;
    if (pin.value.length == 4) {
      if (isReType.value) {
        if (pin.value == initialPin.value) {
          buildSnackBar(S.success_create_pin, true);
          final pincodeJson = jsonEncode(pin.value);
          _localStorage
              .setString('pinNumber', pincodeJson)
              .then((_) async {})
              .catchError((error) {});
          resetAll();
          N.toHome(input: HomeInput(""));
          _localStorage.getString('pinNumber').then((value) {
            L.info('Pin number: $value');
          });
        } else {
          buildSnackBar(S.pin_mismatch, false);
          pinController.clear();
        }
      } else {
        initialPin.value = pin.value;
        pinController.clear();
        isReType.value = true;
      }
    }
  }

  void resetAll() {
    pin.value = '';
    isCheckOldPin.value = false;
    isReType.value = false;
    pinController.clear();
    initialPin.value = '';
  }

  void onPinModified() async {
    pin.value = pinController.text.trim();
    if (!isCheckOldPin.value) {
      var stringResponse = await _localStorage.getString('pinNumber');
      var currentPin = stringResponse!.substring(1, 5);
      L.info('Current numberr: $currentPin');
      L.info('New number: ${pin.value}');
      L.info('state pf isCheckOldPin: ${isCheckOldPin.value}');
      L.info('state pf isReType: ${isReType.value}');
      L.info('state pf pin: ${pin.value}');
      L.info('state pf initialPin: ${initialPin.value}');
      L.info('state pf pinController: ${pinController.text}');

      if (pin.value.length == 4) {
        L.info('Current number: $currentPin');

        if (pin.value == currentPin) {
          pinController.clear();
          isCheckOldPin.value = true;
          pin.value = '';
        } else {
          buildSnackBar(S.pin_mismatch, false);
          pinController.clear();
        }
      }
    } else if (!isReType.value) {
      if (pin.value.length == 4) {
        initialPin.value = pin.value;
        pinController.clear();
        isReType.value = true;
        pin.value = '';
      }
    } else {
      if (pin.value.length == 4) {
        if (pin.value == initialPin.value) {
          await _localStorage
              .setString('pinNumber', jsonEncode(pin.value))
              .then((_) {
            buildSnackBar(S.success_create_pin, true);
            N.toAccount();
            resetAll();
          }).catchError((error) {
            buildSnackBar(S.pin_mismatch, false);
          });
        } else {
          buildSnackBar(S.pin_mismatch, false);
          pinController.clear();
          isReType.value = false;
          initialPin.value = '';
        }
      }
    }
  }

  bool validatePassword(String password) {
    if (password.length < 8) {
      buildSnackBar(S.at_least_8_characters, false);
      return false;
    }
    if (password.contains(' ')) {
      buildSnackBar(S.not_included_space, false);
      return false;
    }
    final regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!regex.hasMatch(password)) {
      buildSnackBar(
          S.included_uppercase_lowercase_number_special_character, false);
      return false;
    }
    return true;
  }

  void handleChangePassword() {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (!validatePassword(newPassword)) {
      return;
    }

    if (newPassword != confirmPassword) {
      buildSnackBar(S.password_mismatch, false);
      return;
    }
    updatePassword(ChangePasswordRequest(
      oldPassword: currentPassword,
      newPassword: newPassword,
    ));
  }

  @override
  void onClose() {
    pinController.removeListener(onPinCreated);
    pinController.removeListener(onPinModified);

    // pinController.dispose();
    focusNode.dispose();

    pushNotiService.cancelNotification();
    _getProfileUseCase.dispose();
    _updateProfileUseCase.dispose();
    super.onClose();
  }

  void navigateToDeposit() {
    final depositInput = DepositInput(user.value.point ?? 0);
    Get.toNamed('/deposit', arguments: depositInput);
  }

  void navigateToAccountInfo() {
    N.toAccountInfo();
  }

  void navigateToSetPin() {
    N.toSetPin();
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

  Future<void> updatePassword(ChangePasswordRequest changePasswordRequest) {
    return _updatePasswordUseCase.execute(
        observer: Observer(
          onSuccess: (_) {
            L.info("Password updated successfully");
            buildSnackBar(S.success_change_password, true);
            N.toAccount();
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: changePasswordRequest);
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
