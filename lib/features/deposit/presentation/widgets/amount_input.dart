import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:get/get.dart';


  Widget buildAmountInput(AppColors? appColors) {
    final controller = Get.find<DepositController>();
    final accountController = Get.find<AccountController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: controller.amountController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyle.bold18().copyWith(
                            color: appColors?.secondary,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: S.zero,
                          ),
                          onChanged: controller.onAmountChanged),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.clearAmount();
                      },
                      child: Icon(Icons.clear, color: appColors?.gray),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.current_money,
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.secondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                formatPrice(accountController.user.value.point ?? 0),
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }