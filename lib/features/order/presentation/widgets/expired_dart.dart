import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Text buildExpirationDate(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return Text(
    "${SS.expired_date}${AppConstants.dateTimeFormat.format(DateTime.now().add(const Duration(hours: 8)))}",
    style: AppTextStyle.bold12().copyWith(color: appColors!.secondary),
  );
}
