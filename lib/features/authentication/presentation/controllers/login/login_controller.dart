import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/app_error.dart';
import 'package:flutter_base_v2/base/domain/base_observer.dart';
import 'package:flutter_base_v2/base/domain/base_state.dart';
import 'package:flutter_base_v2/base/domain/dispose_bag.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/authentication/data/request_body/login_body.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/login/login_uc.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/extension/form_builder.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();
  final loginState = BaseState();

  final isHidePassword = true.obs;
  final isDisableButton = true.obs;
  final ignoringPointer = false.obs;
  final isLoggedInGoogle = false.obs;

  final LoginWithEmailUseCase _loginWithEmailUseCase;
  final LoginWithGoogleUseCase _loginWithGoogleUseCase;
  final LoginWithAppleUseCase _loginWithAppleUseCase;

  String get _email => emailTextEditingController.text;
  String get _password => passwordTextEditingController.text;

  LoginController(this._loginWithEmailUseCase, this._loginWithGoogleUseCase,
      this._loginWithAppleUseCase);

  @override
  void onInit() {
    super.onInit();
    emailTextEditingController.text = 'test02dev@yopmail.com';
    passwordTextEditingController.text = '123456@Aa';
    emailTextEditingController.disposeBy(disposeBag);
    passwordTextEditingController.disposeBy(disposeBag);
    updateLoginButtonState(); // TODO remove
    checkIfLoggedInGoogle();
  }

  @override
  void onClose() {
    _loginWithEmailUseCase.dispose();
    _loginWithGoogleUseCase.dispose();
    super.onClose();
  }

  void onTapEye() {
    isHidePassword.value = !isHidePassword.value;
  }

  void updateLoginButtonState() {
    isDisableButton.value = _email.isEmpty || _password.isEmpty;
  }

  void appleSignIn() {
    _loginWithAppleUseCase.execute(
        observer: Observer(
      onSuccess: (_) {
        L.fatal('Firebase login apple success');
      },
      onError: (AppException e) {
        handleError(e);
      },
    ));
  }

  void googleSignIn() {
    _loginWithGoogleUseCase.execute(
        observer: Observer(
      onSuccess: (_) {
        L.fatal('Firebase login google success');
        checkIfLoggedInGoogle();
      },
      onError: (AppException e) {
        handleError(e);
      },
    ));
  }

  void logoutGoogle() async {
    await Get.find<AuthService>(tag: AuthServiceType.google.name).logout();
    checkIfLoggedInGoogle();
  }

  void checkIfLoggedInGoogle() async {
    isLoggedInGoogle.value =
        await Get.find<AuthService>(tag: AuthServiceType.google.name)
            .isAuthenticated();
  }

  void onTapLogin() {
    try {
      final fbs = formKey.formBuilderState!;
      final emailField = FormFieldType.email.field(fbs);
      final passwordField = FormFieldType.password.field(fbs);
      [
        emailField,
        passwordField,
      ].validateFormFields();

      if (loginState.isLoading) return;

      _loginWithEmailUseCase.execute(
        observer: Observer(
          onSubscribe: () {
            loginState.onLoading();
            ignoringPointer.value = true;
          },
          onSuccess: (_) {
            loginState.onSuccess();
            N.toHome(
              input: HomeInput(_email.trim(), _password.trim()),
            );
          },
          onError: (AppException e) {
            loginState.onError(e.message);
            ignoringPointer.value = false;
            handleError(e, logoutOnUnauthorized: false);
          },
        ),
        input: LoginBody(
          _email.trim(),
          _password.trim(),
        ),
      );
    } on AppException catch (e) {
      L.error(e);
    }
  }
}
