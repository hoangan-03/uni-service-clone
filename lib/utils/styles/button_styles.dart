import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

ButtonStyle elevatedButtonStyle(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return ElevatedButton.styleFrom(
    backgroundColor: appColors!.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    minimumSize: const Size(double.infinity, 40),
  );
}

TextStyle elevatedButtonTextStyle(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return AppTextStyle.bold12().copyWith(color: appColors?.constantWhite);
}
