import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/deposit/presentation/widgets/amount_input.dart';
import 'package:flutter_base_v2/features/deposit/presentation/widgets/preset_amount_buttons.dart';
import 'package:flutter_base_v2/features/transfer/presentation/widgets/continue_button_transfer.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

class TransferPage extends BaseGetView<TransferController> {
  final String recipientId;
  TransferPage({required this.recipientId, super.key});
  final AccountController accountController = Get.find<AccountController>();

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).deposit,
        appColors: appColors,
        hasBackButton: false,
      ),
      backgroundColor: appColors!.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          buildAmountInput(appColors, "transfer"),
          const SizedBox(height: 20),
          buildPresetAmountButtons(appColors, "transfer"),
          const SizedBox(height: 20),
          ContinueButton(
            controller: controller,
            recipientId: recipientId,
          ),
        ],
      ),
    );
  }
}
