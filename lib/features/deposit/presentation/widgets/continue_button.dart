import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildContinueButton(AppColors? appColors) {
final controller = Get.find<DepositController>();
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final amount = int.tryParse(controller.currentAmount.value.replaceAll('.', '')) ?? 0;
            controller.depositRequest(amount);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 6),
            backgroundColor: appColors?.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            S.continue_text,
            style: AppTextStyle.bold12().copyWith(color: appColors?.white),
          ),
        ),
      ),
    );
  }