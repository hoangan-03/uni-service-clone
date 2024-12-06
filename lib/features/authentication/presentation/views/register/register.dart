import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/widgets/info_field.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';

class RegisterPage extends BaseGetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: S.of(context).register,
          appColors: appColors,
          hasBackButton: true,
        ),
        backgroundColor: appColors?.white,
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfoField2(
                  context,
                  S.of(context).email_or_phone,
                  appColors ?? AppColors(),
                  (value) => controller.registerRequest.value.email = value,
                ),
                const SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              controller
                  .getOTP(controller.registerRequest.value.email ?? S.of(context).myEmail);
            },
            style: elevatedButtonStyle(context),
            child: Text(
              S.of(context).send_otp,
              style: elevatedButtonTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}
