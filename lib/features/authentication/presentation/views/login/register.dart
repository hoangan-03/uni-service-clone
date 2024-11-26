import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';

class RegisterPage extends BaseGetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    // final AccountController controller = Get.put(AccountController());

    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: "Đăng ký",
          appColors: appColors,
          hasBackButton: true,
        ),
        backgroundColor: appColors?.white,
        body: Obx(() => IgnorePointer(
              ignoring: controller.ignoringPointer.value,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoField(
                        context,
                        'Email hoặc số điện thoại',
                        appColors,
                        (value) =>
                            controller.registerRequest.value.email = value,
                      ),
                      const SizedBox(height: 80.0),
                    ],
                  ),
                ),
              ),
            )),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              controller.getOTP();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appColors?.primary ?? Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              'Gửi OTP',
              style: AppTextStyle.bold12().copyWith(
                color: appColors?.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoField(BuildContext context, String label,
      AppColors? appColors, Function(String) onChanged,
      {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular14().copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        Obx(() => IgnorePointer(
              ignoring: controller.ignoringPointer.value,
              child: TextFormField(
                initialValue: "",
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'Nhập email hoặc số điện thoại',
                  suffixIcon: icon != null
                      ? Icon(icon, color: appColors?.secondary)
                      : null,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: AppTextStyle.regular14().copyWith(color: Colors.black),
              ),
            )),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
