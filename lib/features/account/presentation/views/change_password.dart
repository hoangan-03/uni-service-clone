import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends BaseGetView<AccountController> {
  const ChangePasswordPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: S.change_pass,
          appColors: appColors,
          hasBackButton: true,
        ),
        backgroundColor: appColors?.white,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildPasswordField(
                    context,
                    controller,
                    controller.currentPasswordController,
                    appColors,
                    hintText: S.retype_current_password,
                  ),
                  const SizedBox(height: 16.0),
                  buildPasswordField(
                    context,
                    controller,
                    controller.newPasswordController,
                    appColors,
                    hintText: S.enter_new_password,
                  ),
                  const SizedBox(height: 16.0),
                  buildPasswordField(
                    context,
                    controller,
                    controller.confirmPasswordController,
                    appColors,
                    hintText: S.confirm_new_password,
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
            );
          }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              controller.handleChangePassword();
            },
            style: elevatedButtonStyle(context),
            child: Text(
              S.continue_text,
              style: elevatedButtonTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(
    BuildContext context,
    AccountController controller,
    TextEditingController textEditingController,
    AppColors? appColors, {
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: AppTextStyle.regular12().copyWith(color: appColors!.gray),
        ),
        const SizedBox(height: 4.0),
        Obx(() => TextFormField(
              controller: textEditingController,
              obscureText: controller.isHidePassword.value,
              decoration: InputDecoration(
                hintText: hintText,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isHidePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: appColors.secondary,
                  ),
                  onPressed: controller.onTapEye,
                ),
                filled: true,
                fillColor: appColors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
              ),
            )),
      ],
    );
  }
}