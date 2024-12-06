import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildInfoField(BuildContext context, String label, String value,
    AppColors? appColors, Function(String) onChanged,
    {IconData? icon, required String hintText}) {
  final bool isDarkMode = Get.isDarkMode;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyle.regular14().copyWith(color: appColors!.gray),
      ),
      const SizedBox(height: 4.0),
      TextFormField(
        initialValue: value,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon:
              icon != null ? Icon(icon, color: appColors.secondary) : null,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
          constraints: BoxConstraints(
            maxHeight: 40.0,
            minHeight: 40.0,
          ),
        ),
        style: AppTextStyle.regular12().copyWith(color: appColors.secondary),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

Widget buildInfoField2(BuildContext context, String label, AppColors appColors,
    Function(String) onChanged,
    {IconData? icon}) {
  final bool isDarkMode = Get.isDarkMode;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyle.regular14().copyWith(color: appColors.gray),
      ),
      const SizedBox(height: 4.0),
      TextFormField(
        initialValue: S.of(context).myEmail,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: S.of(context).enter_email_or_phone,
          suffixIcon:
              icon != null ? Icon(icon, color: appColors.secondary) : null,
          filled: true,
          fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
          constraints: BoxConstraints(
            maxHeight: 40.0,
            minHeight: 40.0,
          ),
        ),
        style: AppTextStyle.regular12().copyWith(color: appColors.secondary),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}

Widget buildPasswordField(BuildContext context, RegisterController controller,
    String value, AppColors? appColors, Function(String) onChanged,
    {required String hintText}) {
  final bool isDarkMode = Get.isDarkMode;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        S.of(context).password,
        style: AppTextStyle.regular14().copyWith(color: appColors!.gray),
      ),
      const SizedBox(height: 4.0),
      Obx(() => TextFormField(
            style:
                AppTextStyle.regular12().copyWith(color: appColors.secondary),
            initialValue: value,
            onChanged: onChanged,
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
              fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
              constraints: BoxConstraints(
                maxHeight: 40.0,
                minHeight: 40.0,
              ),
            ),
          )),
      const SizedBox(height: 16.0),
    ],
  );
}
