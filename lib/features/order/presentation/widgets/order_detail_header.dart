import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Text buildOrderDetailsHeader(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return Text(
    S.of(context).order_detail,
    style: AppTextStyle.bold16().copyWith(color: appColors!.secondary),
  );
}
