import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/domain/dispose_bag.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/models/token_model.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/getOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/update_info.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/verifyOTP_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/get_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/update_info_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/verify_otp_uc.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  var tokenResponse = TokenModel().obs;

  final isHidePassword = true.obs;
  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final isLoggedInGoogle = false.obs;
  UpdateInfoUsecase get _updateInfoUseCase => Get.find<UpdateInfoUsecase>();
  GetOtpUsecase get _getOtpUsecase => Get.find<GetOtpUsecase>();
  VerifyOtpUsecase get _verifyOtpUsecase => Get.find<VerifyOtpUsecase>();

  String get _email => emailTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  @override
  void onInit() {
    super.onInit();
    emailTextEditingController.text = 'vinhthv1@yopmail.com';
    passwordTextEditingController.text = '123456Aa!';
    // emailTextEditingController.text = 'test02dev@yopmail.com';
    // passwordTextEditingController.text = '123456@Aa';
    emailTextEditingController.disposeBy(disposeBag);
    passwordTextEditingController.disposeBy(disposeBag);
    updateLoginButtonState();
  }

  @override
  void onClose() {
    _updateInfoUseCase.dispose();
    super.onClose();
  }

  void onTapEye() {
    isHidePassword.value = !isHidePassword.value;
  }

  void updateLoginButtonState() {
    isDisableButton.value = _email.isEmpty || _password.isEmpty;
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

  Future<void> getOtp(String email) async {
    final params = GetOTPBody(email);
    return _getOtpUsecase.execute(
      observer: Observer(
        onSuccess: (_) {
          L.info('Get OTP success');
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
}
