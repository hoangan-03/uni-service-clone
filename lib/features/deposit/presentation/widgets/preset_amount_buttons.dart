import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildPresetAmountButtons(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildPresetAmountButton(appColors, S.fifty_thousand),
          _buildPresetAmountButton(appColors, S.one_hundred_thousand),
          _buildPresetAmountButton(appColors, S.two_hundred_thousand),
          _buildPresetAmountButton(appColors, S.five_hundred_thousand),
          _buildPresetAmountButton(appColors, S.one_million),
          _buildPresetAmountButton(appColors, S.two_million),
        ],
      ),
    );
  }

  Widget _buildPresetAmountButton(AppColors? appColors, String amount) {
    final controller = Get.find<DepositController>();
    return SizedBox(
      width: 80,
      child: OutlinedButton(
        onPressed: () {
          controller.setAmount(amount);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          backgroundColor: appColors?.white,
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          amount,
          style: AppTextStyle.bold12().copyWith(
            color: appColors?.secondary,
          ),
        ),
      ),
    );
  }