import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:flutter_base_v2/features/transactions/presentation/widgets/date_picker.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
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
          label: SS.from,
          date: controller.fromDate,
          onDateSelected: (date) {
            controller.updateFromDate(date);
          },
        ),
        const SizedBox(width: 16),
        DatePicker(
          label: SS.to,
          date: controller.toDate,
          onDateSelected: (date) {
            controller.updateToDate(date);
          },
        ),
      ],
    );
  }
}