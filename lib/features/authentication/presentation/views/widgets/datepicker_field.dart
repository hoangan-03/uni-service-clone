import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildDatePickerField(BuildContext context, String label, String value,
    AppColors? appColors, Function(String) onChanged) {
          final bool isDarkMode = Get.isDarkMode;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: AppTextStyle.regular14().copyWith(color: appColors!.gray),
      ),
      const SizedBox(height: 4.0),
      GestureDetector(
        onTap: () async {
          DateTime? pickedDate;
          try {
            pickedDate = value.isNotEmpty
                ? AppConstants.dateFormat.parse(value)
                : DateTime.now();
          } catch (e) {
            pickedDate = DateTime.now();
          }

          final selectedDate = await showDatePicker(
            context: context,
            initialDate: pickedDate,
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (selectedDate != null) {
            onChanged(AppConstants.dateFormat.format(selectedDate));
          }
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 40.0,
            minHeight: 40.0,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.transparent),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value.isNotEmpty ? value : S.of(context).enter_birthday,
                style: AppTextStyle.regular12()
                    .copyWith(color: appColors.secondary),
              ),
              Icon(Icons.calendar_today, color: appColors.secondary),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16.0),
    ],
  );
}
