// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TopNavButton extends StatelessWidget {
  final String svgUrl;
  final String label;
  final String currentMenu;
  final Function(String) onMenuSelected;

  const TopNavButton({
    super.key,
    required this.svgUrl,
    required this.label,
    required this.currentMenu,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final bool isSelected = currentMenu == label;
    final bool isDarkMode = Get.isDarkMode;

    return GestureDetector(
      onTap: () {
        onMenuSelected(label);
      },
      child: Container(
        constraints: BoxConstraints(minWidth: 65),
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isDarkMode
                  ? (isSelected ? appColors?.primary : appColors?.transparent)
                  : (isSelected ? appColors?.background : appColors?.white),
          border: Border.all(
              color: isSelected
                  ? appColors!.transparent
                  : isDarkMode ?  appColors?.lightGray ?? Colors.grey : appColors!.gray, width: 0.5),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              svgUrl,
              height: 18,
              color: isDarkMode
                  ? (isSelected ? appColors?.secondary : appColors?.secondary)
                  : (isSelected ? appColors?.primary : appColors?.secondary),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyle.medium12().copyWith(
                color: isDarkMode
                    ? (isSelected ? appColors?.secondary : appColors?.secondary)
                    : (isSelected ? appColors?.primary : appColors?.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}