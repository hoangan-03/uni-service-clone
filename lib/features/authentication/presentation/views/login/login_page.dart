import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/login/login_controller.dart';
import 'package:flutter_base_v2/utils/extension/form_builder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginPage extends BaseGetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: 'Login',
        ),
        body: Obx(() => IgnorePointer(
              ignoring: controller.ignoringPointer.value,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CommonTextField(
                            type: FormFieldType.email,
                            formKey: controller.formKey,
                            controller: controller.emailTextEditingController,
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                          ),
                          CommonTextField(
                            type: FormFieldType.password,
                            formKey: controller.formKey,
                            controller:
                                controller.passwordTextEditingController,
                            textInputAction: TextInputAction.done,
                            obscureText: controller.isHidePassword.value,
                            suffixIcon: Text(
                              'S.current.forgot_password',
                              style: context.textTheme.labelMedium
                                  ?.copyWith(color: context.theme.primaryColor),
                            ),
                            onChanged: (_) {
                              controller.updateLoginButtonState();
                            },
                            onSubmitted: (_) {
                              controller.onTapLogin();
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Obx(() => CommonBottomButton(
                        text: 'Login',
                        onPressed: controller.onTapLogin,
                        pressedOpacity:
                            controller.isDisableButton.value ? 1 : 0.4,
                        isDisable: controller.isDisableButton.value,
                        state: controller.loginState,
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
