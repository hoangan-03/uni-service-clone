import 'package:flutter/material.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';

Row buildTotalPrice(BuildContext context, int totalPrice) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).total_price,
          style: AppTextStyle.bold16().copyWith(color: appColors!.secondary),
        ),
        Text(
          '${formatPrice(totalPrice)} đ',
          style: AppTextStyle.bold16().copyWith(color: appColors.primary),
        ),
      ],
    );
  }