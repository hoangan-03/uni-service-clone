import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Widget buildInfoField(BuildContext context, String label, String value,
    AppColors? appColors, Function(String) onChanged,
    {IconData? icon, required String hintText}) {
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
          hintText: hintText,
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

Widget buildInfoField2(BuildContext context, String label, AppColors appColors,
    Function(String) onChanged,
    {IconData? icon}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyle.regular14().copyWith(color: appColors.gray),
      ),
      const SizedBox(height: 4.0),
      TextFormField(
        initialValue: S.myEmail,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: S.enter_email_or_phone,
          suffixIcon:
              icon != null ? Icon(icon, color: appColors.secondary) : null,
          filled: true,
          fillColor: appColors.lightGray,
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
