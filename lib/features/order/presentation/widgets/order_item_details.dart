import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';

Row buildOrderItemDetails(BuildContext context, int quantity, int totalPrice,
    String name, String description, String imageUrl) {
  final appColors = Theme.of(context).extension<AppColors>();
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style:
                  AppTextStyle.bold14().copyWith(color: appColors!.secondary),
            ),
            const SizedBox(height: 4.0),
            Text(
              description,
              style: AppTextStyle.regular12().copyWith(color: appColors.gray),
            ),
          ],
        ),
      ),
      _buildOrderItemPriceDetails(appColors, quantity, totalPrice),
    ],
  );
}

Column _buildOrderItemPriceDetails(
    AppColors? appColors, int quantity, int totalPrice) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        'x$quantity',
        style: AppTextStyle.regular14().copyWith(color: appColors!.secondary),
      ),
      const SizedBox(height: 4.0),
      Text(
        '${formatPrice(totalPrice)} đ',
        style: AppTextStyle.bold14().copyWith(color: appColors.secondary),
      ),
    ],
  );
}
