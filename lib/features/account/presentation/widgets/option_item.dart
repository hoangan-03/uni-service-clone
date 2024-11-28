// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_svg/svg.dart';

Widget buildOptionItem(
    AppColors? appColors, String svgUrl, String title, VoidCallback onTap) {
  return ListTile(
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: appColors?.lightGray.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(
        svgUrl,
        height: 16,
        width: 16,
        color: appColors?.primary,
      ),
    ),
    title: Text(
      title,
      style: AppTextStyle.bold14(),
    ),
    onTap: onTap,
  );
}
