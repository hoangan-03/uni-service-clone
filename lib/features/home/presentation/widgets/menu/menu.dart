import 'package:flutter/material.dart';
import "package:flutter_base_v2/base/presentation/widgets/app_bar.dart";
import "package:flutter_base_v2/features/home/domain/entities/menu.dart";
import "package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart";
import "package:flutter_base_v2/utils/helper/get_cate_title.dart";
import "package:flutter_base_v2/features/home/presentation/widgets/order/order.dart";
import "package:flutter_base_v2/features/home/presentation/widgets/order/order_slider.dart";
import "package:flutter_base_v2/utils/config/app_text_style.dart";
import "package:flutter_base_v2/utils/config/app_theme.dart";
import "package:get/get.dart";

class MenuPage extends StatelessWidget {
  final String title;
  final List<Menu> menuItems;

  const MenuPage({super.key, required this.title, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: appColors?.white,
      appBar: buildAppBar(
          appColors: appColors,
          context: context,
          title: getCategoryTitle(title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: appColors?.gray ?? Colors.grey, width: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.product.imageURL,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.product.name,
                                style: AppTextStyle.bold15()
                                    .copyWith(color: appColors?.secondary),
                              ),
                              Text(
                                item.product.description,
                                style: AppTextStyle.medium14()
                                    .copyWith(color: appColors?.secondary),
                              ),
                              const SizedBox(height: 4),
                              // Text(
                              //   item.product.quantity,
                              //   style: AppTextStyle.regular14()
                              //       .copyWith(color: appColors?.secondary),
                              // ),
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
                            child: Icon(Icons.add,
                                color: appColors?.white, size: 18),
                          ),
                          onPressed: () {
                            showOrderSlider(
                              context,
                              item,
                              initialQuantity: controller.quantity.value,
                              onQuantityChanged: (newQuantity) {
                                controller.updateQuantity(newQuantity);
                              },
                              onOrderPlaced: () {
                                Get.to(() => OrderPage(
                                      item: item,
                                      quantity: 1,
                                      itemIndex: 0,
                                    ));
                              },
                              shouldNavigate: true,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
