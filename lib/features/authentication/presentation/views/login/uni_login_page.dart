import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/login/login_controller.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/login/widgets/widgets.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/extension/form_builder.dart';
import 'package:flutter_base_v2/utils/gen/assets.gen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UniLoginPage extends BaseGetView<LoginController> {
  const UniLoginPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        body: Obx(() => IgnorePointer(
              ignoring: controller.ignoringPointer.value,
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const AppLogo(),
                    const SizedBox(height: 16),
                    FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          CommonTextField(
                            type: FormFieldType.email,
                            formKey: controller.formKey,
                            controller: controller.emailTextEditingController,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                          ),
                          const SizedBox(height: 24),
                          Obx(() => CommonTextField(
                              type: FormFieldType.password,
                              obscureText: controller.isHidePassword.value,
                              formKey: controller.formKey,
                              controller:
                                  controller.passwordTextEditingController,
                              suffixIcon: controller.isHidePassword.value
                                  ? Assets.icons.icEyeOff.svg()
                                  : Assets.icons.icEyeOn.svg(),
                              onPressedSuffixIcon: controller.onTapEye,
                              onChanged: (_) {
                                controller.updateLoginButtonState();
                              })),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Obx(() => controller.isLoggedInGoogle.value
                        ? Column(
                            children: [
                              CommonButton(
                                  fillColor: appColors!.primary,
                                  onPressed: controller.logoutGoogle,
                                  enabled: !controller.isDisableButton.value,
                                  state: controller.loginState,
                                  child: Text(
                                    'Logout Google',
                                    style: AppTextStyle.regular14(
                                        color: appColors.white),
                                  )),
                              const SizedBox(height: 16)
                            ],
                          )
                        : Column(
                            children: [
                              CommonButton(
                                  fillColor: appColors!.primary,
                                  onPressed: controller.googleSignIn,
                                  enabled: !controller.isDisableButton.value,
                                  state: controller.loginState,
                                  child: Text(
                                    'Login with Google',
                                    style: AppTextStyle.regular14(
                                        color: appColors.white),
                                  )),
                              const SizedBox(height: 16)
                            ],
                          )),
                    SignInWithAppleButton(
                      onPressed: controller.appleSignIn,
                    ),
                    const SizedBox(height: 16),
                    Obx(() => CommonButton(
                        fillColor: appColors!.primary,
                        onPressed: controller.onTapLogin,
                        enabled: !controller.isDisableButton.value,
                        state: controller.loginState,
                        child: Text(
                          S.login,
                          style: AppTextStyle.regular14(
                              color: appColors.white),
                        ))),
                  ],
                ),
              )),
            )),
      ),
    );
  }
}
