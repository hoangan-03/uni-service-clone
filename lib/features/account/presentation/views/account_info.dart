import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_base_v2/features/account/domain/entities/user.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

class AccountInfoPage extends StatelessWidget {
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thông tin tài khoản',
          style: AppTextStyle.bold16().copyWith(color: appColors?.secondary),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white, // Set background color of the body to white
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final user = controller.user.value;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildInfoField(context, 'Họ tên', user.username ?? '', appColors),
                buildInfoField(context, 'CCCD', user.identificationCard ?? '', appColors),
                buildInfoField(
                  context,
                  'Ngày sinh',
                  user.birthdate ?? '',
                  appColors,
                  icon: Icons.calendar_today,
                ),
                buildInfoField(context, 'Trường', user.school ?? '', appColors),
                buildInfoField(context, 'Khoa', user.faculty ?? '', appColors),
                buildInfoField(context, 'Chức vụ', user.position ?? '', appColors),
                buildInfoField(context, 'Loại', user.role ?? '', appColors),
                buildInfoField(context, 'Email', user.email ?? '', appColors),
                buildInfoField(context, 'Số điện thoại', user.phone ?? '', appColors),
                const SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
        }),
      ),
    );
  }

  Widget buildInfoField(BuildContext context, String label, String value,
      AppColors? appColors, {IconData? icon}) {
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
          readOnly: true,
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
