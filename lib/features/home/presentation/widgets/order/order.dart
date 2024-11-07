import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/domain/entities/menu.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
import 'package:flutter_base_v2/features/home/presentation/widgets/order/order_slider.dart';
import 'package:flutter_base_v2/features/order/presentation/views/bill.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class OrderPage extends BaseGetView<HomeController> {
  final Menu item;
  final int quantity;
  final int itemIndex;

  const OrderPage({
    super.key,
    required this.item,
    required this.quantity,
    required this.itemIndex,
  });

  void onInit() {
    controller.updateQuantity(quantity);
    controller.updateItemIndex(itemIndex);
  }

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt món'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.updateQuantity(0);
            controller.updateItemIndex(0);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: appColors?.white,
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.product.imageURL,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            if (item.menu == "TODAY") ...[
              Obx(() {
                final currentItem = item.items![controller.itemIndex.value];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentItem.name,
                      style: AppTextStyle.bold18()
                          .copyWith(color: appColors?.secondary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.product.description,
                      style: AppTextStyle.regular16()
                          .copyWith(color: appColors?.gray),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Số lượng:',
                          style: AppTextStyle.regular18()
                              .copyWith(color: appColors?.secondary),
                        ),
                        Obx(() => Text(
                              '${controller.quantity.value}',
                              style: AppTextStyle.regular18()
                                  .copyWith(color: appColors?.secondary),
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        showOrderSlider(
                          context,
                          item,
                          initialQuantity: controller.quantity.value,
                          onItemSelected: (newIndex) {
                            controller.updateItemIndex(newIndex);
                          },
                          onQuantityChanged: (newQuantity) {
                            controller.updateQuantity(newQuantity);
                          },
                          onOrderPlaced: () {
                            Get.to(() => OrderPage(
                              item: item,
                              quantity: controller.quantity.value,
                              itemIndex: controller.itemIndex.value,
                            ));
                          },
                          shouldNavigate: false,
                          selectedItemIndex: controller.itemIndex.value,
                        );
                      },
                      child: Text(
                        'Chỉnh sửa',
                        style: AppTextStyle.bold18()
                            .copyWith(color: appColors?.primary),
                      ),
                    ),
                  ],
                );
              }),
            ] else ...[
              Text(
                item.product.name,
                style:
                    AppTextStyle.bold18().copyWith(color: appColors?.secondary),
              ),
              const SizedBox(height: 4),
              Text(
                item.product.description,
                style:
                    AppTextStyle.regular16().copyWith(color: appColors?.gray),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Số lượng:',
                    style: AppTextStyle.regular18()
                        .copyWith(color: appColors?.secondary),
                  ),
                  Obx(() => Text(
                        '${controller.quantity.value}',
                        style: AppTextStyle.regular18()
                            .copyWith(color: appColors?.secondary),
                      )),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showOrderSlider(
                    context,
                    item,
                    initialQuantity: controller.quantity.value,
                    onItemSelected: (newIndex) {
                      controller.updateItemIndex(newIndex);
                    },
                    onQuantityChanged: (newQuantity) {
                      controller.updateQuantity(newQuantity);
                    },
                    onOrderPlaced: () {
                        Get.to(() => OrderPage(
                        item: item,
                        quantity: controller.quantity.value,
                        itemIndex: controller.itemIndex.value,
                        ));
                    },
                    shouldNavigate: false,
                    selectedItemIndex: controller.itemIndex.value,
                  );
                },
                child: Text(
                  'Chỉnh sửa',
                  style:
                      AppTextStyle.bold18().copyWith(color: appColors?.primary),
                ),
              ),
            ],
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng cộng:',
                    style: AppTextStyle.bold20()
                        .copyWith(color: appColors?.secondary),
                  ),
                  if (item.menu == "TODAY") ...[
                    Obx(() {
                      final currentItem =
                          item.items![controller.itemIndex.value];
                      return Text(
                        '${formatPrice(((item.type.price != null && item.type.price != 0) ? item.type.price : currentItem.price)! * controller.quantity.value)}đ',
                        style: AppTextStyle.bold20()
                            .copyWith(color: appColors?.onSuccess),
                      );
                    }),
                  ] else ...[
                    Obx(() {
                      return Text(
                        '${formatPrice((item.type.price)! * controller.quantity.value)}đ',
                        style: AppTextStyle.bold20()
                            .copyWith(color: appColors?.onSuccess),
                      );
                    }),
                  ]
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final name = item.product.name;
                  final description = item.product.description;
                  final quantity = controller.quantity.value;
                  final unitPrice =
                      (item.menu == "TODAY")
                          ? item.items![controller.itemIndex.value].price
                          : item.type.price!;
                  final totalPrice = unitPrice * quantity;
                  final branch = item.branchId;
                  final idProduct = item.menu == "TODAY"
                      ? item.items![controller.itemIndex.value].id
                      : item.product.id;
                  controller.addToCart(idProduct, quantity);
                  Get.to(() => BillPage(
                    imageUrl: item.product.imageURL,
                        name: name,
                        description: description,
                        quantity: quantity,
                        totalPrice: totalPrice,
                        branch: branch,
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Thanh toán',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
