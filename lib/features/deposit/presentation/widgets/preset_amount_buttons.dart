import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildPresetAmountButtons(AppColors? appColors, String variant) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _buildPresetAmountButton(appColors, SS.fifty_thousand, variant),
        _buildPresetAmountButton(appColors, SS.one_hundred_thousand, variant),
        _buildPresetAmountButton(appColors, SS.two_hundred_thousand, variant),
        _buildPresetAmountButton(appColors, SS.five_hundred_thousand, variant),
        _buildPresetAmountButton(appColors, SS.one_million, variant),
        _buildPresetAmountButton(appColors, SS.two_million, variant),
      ],
    ),
  );
}

Widget _buildPresetAmountButton(
    AppColors? appColors, String amount, String variant) {
  Get.lazyPut<DepositController>(() => DepositController());
  Get.lazyPut<TransferController>(() => TransferController());
  final transferController = Get.find<TransferController>();
  final depositController = Get.find<DepositController>();

  return SizedBox(
    width: 80,
    child: OutlinedButton(
      onPressed: () {
        if (variant == 'deposit') {
          depositController.setAmount(amount);
        } else {
          transferController.setAmount(amount);
        }
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
