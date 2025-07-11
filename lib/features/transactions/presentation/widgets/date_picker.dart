import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

class DatePicker extends StatelessWidget {
  final String label;
  final Rx<DateTime?> date;
  final Function(DateTime) onDateSelected;
  final DateTime? defaultDate;

  const DatePicker({
    super.key,
    required this.label,
    required this.date,
    required this.onDateSelected,
    this.defaultDate,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: AppTextStyle.bold14().copyWith(color: appColors!.secondary)),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date.value ?? defaultDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              onDateSelected(selectedDate);
            }
          },
          child: Container(
            width: 125,
            padding: const EdgeInsets.only(left: 8, right: 4, top: 4, bottom: 4),
            decoration: BoxDecoration(
              border: Border.all(color: appColors.gray),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date.value != null
                        ? AppConstants.dateFormat.format(date.value!)
                        : AppConstants.dateFormat.format(defaultDate ?? DateTime.now()),
                    style: AppTextStyle.regular12().copyWith(color: appColors.secondary),
                  ),
                  Icon(Icons.expand_more, size: 20, color: appColors.gray),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}