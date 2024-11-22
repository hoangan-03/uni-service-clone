import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class RegisterEmailPage extends BaseGetView<RegisterController> {
  const RegisterEmailPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: "Đăng ký",
        appColors: appColors,
        hasBackButton: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final user = controller.user.value;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoField(context, 'Email hoặc số điện thoại', user.username ?? '',
                        appColors, (value) => user.username = value),
                    const SizedBox(height: 80.0), 
                  ],
                ),
              );
            }),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                final user = controller.user.value;
                controller.updateProfile(user);
                Get.back();
                buildSnackBar("Cập nhật thông tin thành công", true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: appColors?.primary ?? Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Cập nhật thông tin',
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoField(BuildContext context, String label, String value,
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
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixIcon:
                icon != null ? Icon(icon, color: appColors?.secondary) : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppTextStyle.regular14().copyWith(color: Colors.black),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}