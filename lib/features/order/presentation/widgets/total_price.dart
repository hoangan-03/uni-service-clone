import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';

Row buildTotalPrice(BuildContext context, int totalPrice) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          SS.total_price,
          style: AppTextStyle.bold16().copyWith(color: appColors!.secondary),
        ),
        Text(
          '${formatPrice(totalPrice)} đ',
          style: AppTextStyle.bold16().copyWith(color: appColors.primary),
        ),
      ],
    );
  }