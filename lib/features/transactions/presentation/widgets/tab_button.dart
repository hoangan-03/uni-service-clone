import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

 Widget buildTabButton(String label, String? type, AppColors appColors) {
    final controller = Get.find<TransactionController>();
    return Obx(() {
      final isSelected = controller.selectedTransactionType.value == type;
      return GestureDetector(
        onTap: () {
          controller.updateTransactionType(type);
          // controller.pagingController.refresh();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? appColors.background : appColors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: AppTextStyle.bold12().copyWith(
              color: isSelected ? appColors.primary : appColors.secondary,
            ),
          ),
        ),
      );
    });
  }
