import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/order/presentation/views/order_slider.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

Widget buildItemCard(Menu item, BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  final HomeController controller = Get.find<HomeController>();
  return Container(
    width: 130,
    margin: const EdgeInsets.only(top: 10, bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 130,
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
              style: AppTextStyle.bold14().copyWith(color: appColors?.secondary),
            ),
            const SizedBox(height: 2),
            Text(
              '${(item.type.price != null && item.type.price != 0) ? formatPrice(item.type.price ?? 0) : formatPrice(item.items![0].price)}đ',
              style: AppTextStyle.regular12().copyWith(color: appColors?.secondary),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 140,
              height: 35,
              child: TextButton(
                onPressed: () {
                  showOrderSlider(
                    context,
                    item,
                    initialQuantity: controller.quantity.value,
                    onQuantityChanged: (newQuantity) {
                      controller.updateQuantity(newQuantity);
                    },
                    onOrderPlaced: () {},
                    shouldNavigate: true,
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: appColors?.background,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  S.choose_food,
                  style:
                      AppTextStyle.bold11().copyWith(color: appColors?.primary),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
