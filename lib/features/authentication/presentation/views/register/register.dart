import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/widgets/info_field.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';

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
          title: S.register,
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
                  S.email_or_phone,
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
              controller.getOTP(controller.registerRequest.value.email ??
                  S.myEmail);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appColors?.primary ?? Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              S.send_otp,
              style: AppTextStyle.bold12().copyWith(
                color: appColors?.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

}
