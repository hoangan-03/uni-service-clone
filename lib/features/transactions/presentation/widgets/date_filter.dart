import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/date_picker.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:get/get.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionController controller = Get.find<TransactionController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DatePicker(
          label: S.of(context).from,
          date: controller.fromDate,
          onDateSelected: (date) {
            controller.updateFromDate(date);
          },
        ),
        const SizedBox(width: 16),
        DatePicker(
          label: S.of(context).to,
          date: controller.toDate,
          onDateSelected: (date) {
            controller.updateToDate(date);
          },
        ),
      ],
    );
  }
}