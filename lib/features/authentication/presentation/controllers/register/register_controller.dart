import 'dart:async';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/args/email_input.dart';
import 'package:flutter_base_v2/features/authentication/data/models/response/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/models/request/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/get_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/update_info_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/verify_otp_uc.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  var tokenResponse = TokenModel().obs;
  var registerRequest = GetOTPBody('john12052003@gmail.com').obs;
  var otp = ''.obs;
  var canResendOtp = false.obs;
  var otpResendTimer = 30.obs;

  final isHidePassword = true.obs;

  UpdateInfoUsecase get _updateInfoUseCase => Get.find<UpdateInfoUsecase>();
  GetOtpUsecase get _getOtpUsecase => Get.find<GetOtpUsecase>();
  VerifyOtpUsecase get _verifyOtpUsecase => Get.find<VerifyOtpUsecase>();

  Timer? _resendOtpTimer;

  @override
  void onClose() {
    _updateInfoUseCase.dispose();
    _resendOtpTimer?.cancel();
    super.onClose();
  }

  void onTapEye() {
    isHidePassword.value = !isHidePassword.value;
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
          tokenResponse.value = data;
          L.info('OTP verified successfully');
          L.info(data);
        },
        onError: (AppException e) {
          handleError(e);
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
            L.info('OTP sent successfully');
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
      otp.value = otp.value.substring(0, index) + value + otp.value.substring(index + 1);
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
    Get.back();
  }
}