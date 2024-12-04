import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';

class ContinueButton extends StatelessWidget {
  final TransferController controller;
  final String recipientId;

  const ContinueButton({
    super.key,
    required this.controller,
    required this.recipientId,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final amount = int.tryParse(
                    controller.currentAmount.value.replaceAll('.', '')) ??
                0;
            controller.scannedUserQRCode(recipientId, amount);
            buildSnackBar(S.transfer_success, true);
          },
          style: elevatedButtonStyle(context),
          child: Text(
            S.continue_text,
            style: elevatedButtonTextStyle(context),
          ),
        ),
      ),
    );
  }
}
