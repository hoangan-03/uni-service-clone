import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

void buildSnackBar(String message, bool isSuccess) {
  final appColors = Get.context?.theme.extension<AppColors>();
  final icon = isSuccess ? Icons.check_circle : Icons.info;

  Get.showSnackbar(
    GetSnackBar(
      messageText: Row(
        children: [
          Icon(icon, color: appColors!.primary, size: 28.0),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              message,
              style: AppTextStyle.bold15()
                  .copyWith(color: appColors.secondary),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      backgroundColor: appColors.white,
      borderRadius: 36,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      borderColor: appColors.transparent,
      borderWidth: 2.0,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
      isDismissible: false,
    ),
  );
}
