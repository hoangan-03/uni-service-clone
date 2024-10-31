import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/views/order_slider/order_slider.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

Widget buildItemCard(Menu item, BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return Container(
    width: 140,
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(item.product.imageURL),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.product.name,
              style: AppTextStyle.bold16(),
            ),
            const SizedBox(height: 4),
            Text(
              '${item.type.price}đ',
              style: AppTextStyle.regular12(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 140,  
              child: TextButton(
                onPressed: () {
                            showOrderSlider(context, item);
                          },
                style: TextButton.styleFrom(
                  backgroundColor: appColors?.background,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Chọn món',
                  style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
