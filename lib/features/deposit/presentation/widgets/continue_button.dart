import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';

Widget buildContinueButton(BuildContext context) {
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
          style:elevatedButtonStyle(context),
          child: Text(
            S.continue_text,                          
            style: elevatedButtonTextStyle(context),
          ),
        ),
      ),
    );
  }

  