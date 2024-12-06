import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:flutter_base_v2/features/deposit/presentation/widgets/amount_input.dart';
import 'package:flutter_base_v2/features/deposit/presentation/widgets/continue_button.dart';
import 'package:flutter_base_v2/features/deposit/presentation/widgets/preset_amount_buttons.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

class DepositPage extends BaseGetView<DepositController> {
  DepositPage({super.key});
  final AccountController accountController = Get.find<AccountController>();

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: SS.deposit,
        appColors: appColors,
        hasBackButton: true,
      ),
      backgroundColor: appColors!.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          buildAmountInput(appColors, "deposit"),
          const SizedBox(height: 20),
          buildPresetAmountButtons(appColors, "deposit"),
          const SizedBox(height: 20),
          buildContinueButton(context),
        ],
      ),
    );
  }
}
