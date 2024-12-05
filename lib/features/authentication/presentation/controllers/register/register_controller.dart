import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/args/email_input.dart';
import 'package:flutter_base_v2/features/authentication/data/args/token_input.dart';
import 'package:flutter_base_v2/features/authentication/data/models/response/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/get_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/update_info_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/verify_otp_uc.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';

class RegisterController extends BaseController {
  var registerRequest = GetOTPBody('john12052003@gmail.com').obs;
  var otp = ''.obs;
  var userInitInfo = UpdateInfoBody('', '', '').obs;
  var canResendOtp = false.obs;
  var otpResendTimer = 30.obs;
  var accessToken = ''.obs;

  final LocalStorage _localStorage = Get.find();

  final isHidePassword = true.obs;
  final List<FocusNode> otpFocusNodes = List.generate(6, (_) => FocusNode());

  UpdateInfoUsecase get _updateInfoUseCase => Get.find<UpdateInfoUsecase>();
  GetOtpUsecase get _getOtpUsecase => Get.find<GetOtpUsecase>();
  VerifyOtpUsecase get _verifyOtpUsecase => Get.find<VerifyOtpUsecase>();

  Timer? _resendOtpTimer;

  @override
  void onInit() {
    otp.value = ' ' * otpFocusNodes.length;
    super.onInit();
  }

  @override
  void onClose() {
    _updateInfoUseCase.dispose();
    _resendOtpTimer?.cancel();
    for (var node in otpFocusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void onTapEye() {
    isHidePassword.value = !isHidePassword.value;
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
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!regex.hasMatch(password)) {
      buildSnackBar(S.included_uppercase_lowercase_number_special_character, false);
      return false;
    }
    return true;
  }

  Future<void> updateInfo(
      String birthdate, String name, String password) async {
    final params = UpdateInfoBody(birthdate, name, password);
    return _updateInfoUseCase.execute(
      observer: Observer(
        onSuccess: (_) {
          L.info('Update Info success');
        },
        onError: (AppException e) {
          handleError(e);
        },
      ),
      input: params,
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    final params = VerifyOTPBody(email, otp);
    return _verifyOtpUsecase.execute(
      observer: Observer(
        onSuccess: (TokenModel data) {
          buildSnackBar('Xác minh OTP thành công', true);
          accessToken.value = data.accessToken ?? '';
          N.toInitInfo(input: TokenInput(data.accessToken ?? ''));
        },
        onError: (AppException e) {
          buildSnackBar('Mã xác minh không đúng, vui lòng thử lại', false);
        },
      ),
      input: params,
    );
  }

  Future<void> getOTP(String email) {
    final params = GetOTPBody(email);
    return _getOtpUsecase.execute(
        observer: Observer(
          onSuccess: (_) {
            buildSnackBar('Đã gửi OTP', true);
            N.toVerifyOtp(input: EmailInput(email));
            startOtpResendTimer();
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: params);
  }

  void onOtpInput(int index, String value) {
    if (value.isNotEmpty) {
      otp.value = otp.value.substring(0, index) +
          value +
          otp.value.substring(index + 1);
      if (index < otpFocusNodes.length - 1) {
        otpFocusNodes[index + 1].requestFocus();
      } else {
        otpFocusNodes[index].unfocus();
        verifyOtp(registerRequest.value.email ?? '', otp.value);
      }
    }
  }

  void startOtpResendTimer() {
    canResendOtp.value = false;
    otpResendTimer.value = 30;
    _resendOtpTimer?.cancel();
    _resendOtpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (otpResendTimer.value > 0) {
        otpResendTimer.value--;
      } else {
        canResendOtp.value = true;
        timer.cancel();
      }
    });
  }

  void onResendOtp() {
    getOTP(registerRequest.value.email ?? 'john12052003@gmail.com');
  }

  void onChangeEmail() {
    N.toRegister();
  }

  void setAccessToken() {
    _localStorage.saveAccessToken(accessToken.value);
  }

  Future<void> initProfile(UpdateInfoBody initedUser) async {
    return _updateInfoUseCase.execute(
        observer: Observer(
          onSuccess: (_) {
            L.info("Profile inited successfully");
            userInitInfo.value = initedUser;
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: initedUser);
  }

  void handleInit() {
    final user = userInitInfo.value;
    if (validatePassword(user.password)) {
      initProfile(user);
      buildSnackBar(S.success_register, true);
      N.toSetPin();
    }
  }
}