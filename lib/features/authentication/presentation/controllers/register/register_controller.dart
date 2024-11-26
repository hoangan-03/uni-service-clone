import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/get_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/update_info_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/verify_otp_uc.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final registerState = BaseState();

  var tokenResponse = TokenModel().obs;
  var registerRequest = GetOTPBody("").obs;

  final isHidePassword = true.obs;
  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final isLoggedInGoogle = false.obs;
  UpdateInfoUsecase get _updateInfoUseCase => Get.find<UpdateInfoUsecase>();
  GetOtpUsecase get _getOtpUsecase => Get.find<GetOtpUsecase>();
  VerifyOtpUsecase get _verifyOtpUsecase => Get.find<VerifyOtpUsecase>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _updateInfoUseCase.dispose();
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

  Future<void> getOTP() {
    final params = GetOTPBody(registerRequest.value.email);
    return _getOtpUsecase.execute(
        observer: Observer(
          onSuccess: (_) {
            buildSnackBar('Đã gửi OTP', true);
          },
          onError: (AppException e) {
            handleError(e);
          },
        ),
        input: params);
  }
}
