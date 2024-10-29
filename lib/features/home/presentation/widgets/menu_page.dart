import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/data/types/menu_item.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

Widget buildMenuPage(List<MenuItem> items, BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: appColors?.gray ?? Colors.grey, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 80);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: AppTextStyle.bold16()
                        .copyWith(color: appColors?.secondary),
                  ),
                  Text(
                    item.description,
                    style: AppTextStyle.regular14()
                        .copyWith(color: appColors?.gray),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.price,
                    style: AppTextStyle.regular14()
                        .copyWith(color: appColors?.secondary),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: appColors?.primary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.add, color: appColors?.white, size: 18),
              ),
              onPressed: () {},
            ),
          ],
        ),
      );
    },
  );
}
