import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/data/args/email_input.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
class VerifyOtpPage extends BaseGetView<RegisterController> {
  const VerifyOtpPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final EmailInput email = Get.arguments as EmailInput;

    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        // appBar: buildAppBar(
        //   context: context,
        //   title: "Verify OTP",
        //   appColors: appColors,
        //   hasBackButton: true,
        // ),
        backgroundColor: appColors?.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 96),
              Image.asset(
                'assets/images/email.png',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 24),
              Text(
                SS.otp_has_been_sent,
                style: AppTextStyle.regular12()
                    .copyWith(color: appColors?.secondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                email.email,
                style:
                    AppTextStyle.bold16().copyWith(color: appColors?.secondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: SS.wrong_email,
                  style: AppTextStyle.regular12()
                      .copyWith(color: appColors?.secondary),
                  children: [
                    TextSpan(
                      text: SS.change_email,
                      style: AppTextStyle.regular12()
                          .copyWith(color: appColors?.primary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = controller.onChangeEmail,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: appColors!.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      focusNode: controller.otpFocusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTextStyle.bold16().copyWith(color: appColors.primary),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value) {
                        controller.onOtpInput(index, value);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => TextButton(
                    onPressed: controller.canResendOtp.value
                        ? controller.onResendOtp
                        : null,
                    child: Text(
                      controller.canResendOtp.value
                          ? SS.resend_otp
                          : '${SS.resend_otp} (${controller.otpResendTimer}s)',
                      style: AppTextStyle.regular16().copyWith(
                        color: controller.canResendOtp.value
                            ? appColors?.primary
                            : appColors?.secondary,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
