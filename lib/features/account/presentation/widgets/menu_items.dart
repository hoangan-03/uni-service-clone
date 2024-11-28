// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildMenuItem(
  String svgUrl,
  String title,
  BuildContext context, {
  Color color = Colors.black,
  bool showTrailingIcon = true,
  VoidCallback? onTap,
  bool isLogout = false,
}) {
  final appColors = Theme.of(context).extension<AppColors>();
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 11),
      child: Row(
        children: [
          SvgPicture.asset(
            svgUrl,
            width: 20,
            height: 20,
            color: isLogout ? appColors!.onCancel : appColors!.secondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.regular13().copyWith(color: color),
            ),
          ),
          if (showTrailingIcon)
            Icon(Icons.arrow_forward_ios, size: 12, color: appColors.gray),
        ],
      ),
    ),
  );
}