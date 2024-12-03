 import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Text buildBillTimestamp(String currentTime, BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
    return Text(
      currentTime,
      style: AppTextStyle.regular12().copyWith(color: appColors!.gray),
    );
  }