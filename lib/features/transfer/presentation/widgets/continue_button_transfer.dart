import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';

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
    final appColors = Theme.of(context).extension<AppColors>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final amount = int.tryParse(
                    controller.currentAmount.value.replaceAll('.', '')) ?? 0;
            controller.scannedUserQRCode(recipientId, amount);
            buildSnackBar("Chuyển tiền thành công", true);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 6),
            backgroundColor: appColors?.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Tiếp tục',
            style: AppTextStyle.bold12().copyWith(color: appColors?.white),
          ),
        ),
      ),
    );
  }
}