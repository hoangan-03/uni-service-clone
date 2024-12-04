import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/order/presentation/views/order_slide_qr.dart';
import 'package:flutter_base_v2/features/qrcode/domain/entities/menu_qr.dart';
import 'package:flutter_base_v2/features/order/presentation/views/bill.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class OrderQRPage extends BaseGetView<HomeController> {
  final MenuQR item;
  final int quantity;
  final int itemIndex;

  const OrderQRPage({
    super.key,
    required this.item,
    required this.quantity,
    required this.itemIndex,
  });

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: _buildAppBar(appColors, context),
      body: _buildBody(context, appColors, controller),
    );
  }

  AppBar _buildAppBar(AppColors? appColors, BuildContext context) {
    return AppBar(
      title: Text(S.order,
          style: AppTextStyle.bold20().copyWith(color: appColors?.secondary)),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          controller.updateQuantity(0);
          controller.updateItemIndex(0);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, AppColors? appColors, HomeController controller) {
    return Container(
      decoration: BoxDecoration(
        color: appColors?.white,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          const SizedBox(height: 16),
          _buildProductDetails(appColors),
          const Spacer(),
          _buildTotalAmount(appColors),
          const SizedBox(height: 16),
          _buildCheckoutButton(context),
        ],
      ),
    );
  }

  ClipRRect _buildProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        item.product!.imageURL,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProductDetails(AppColors? appColors) {
    return _RegularMenuDetails(
      item: item,
      appColors: appColors,
      controller: controller,
    );
  }

  Padding _buildTotalAmount(AppColors? appColors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.total_price,
            style: AppTextStyle.bold20().copyWith(color: appColors?.secondary),
          ),
          Obx(() {
            return Text(
              '${formatPrice((item.type.price)! * controller.quantity.value)}đ',
              style:
                  AppTextStyle.bold20().copyWith(color: appColors?.onSuccess),
            );
          }),
        ],
      ),
    );
  }

  SizedBox _buildCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          final name = item.product!.name;
          final description = item.product!.description;
          final quantity = controller.quantity.value;
          final unitPrice = item.type.price!;
          final totalPrice = unitPrice * quantity;
          final branch = item.branchId;
          final idProduct = item.id;
          await controller.addToCart(idProduct!, quantity);
          await controller.getQrCode(idProduct);
          Get.to(() => BillPage(
                imageUrl: item.product!.imageURL,
                name: name,
                description: description,
                quantity: quantity,
                totalPrice: totalPrice,
                branch: branch ?? '',
                branchName: item.branch!.name,
              ));
        },
        style: elevatedButtonStyle(context),
        child: Text(
          S.make_payment,
          style: elevatedButtonTextStyle(context),
        ),
      ),
    );
  }
}

class _RegularMenuDetails extends StatelessWidget {
  final MenuQR item;
  final AppColors? appColors;
  final HomeController controller;

  const _RegularMenuDetails({
    required this.item,
    required this.appColors,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.product!.name,
          style: AppTextStyle.bold18().copyWith(color: appColors?.secondary),
        ),
        const SizedBox(height: 4),
        Text(
          item.product!.description,
          style: AppTextStyle.regular16().copyWith(color: appColors?.gray),
        ),
        const SizedBox(height: 16),
        _buildQuantityDetails(appColors, controller),
        const SizedBox(height: 8),
        _buildEditButton(appColors, context, controller),
      ],
    );
  }

  Row _buildQuantityDetails(AppColors? appColors, HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.quantity,
          style: AppTextStyle.regular18().copyWith(color: appColors?.secondary),
        ),
        Obx(() => Text(
              '${controller.quantity.value}',
              style: AppTextStyle.regular18()
                  .copyWith(color: appColors?.secondary),
            )),
      ],
    );
  }

  GestureDetector _buildEditButton(
      AppColors? appColors, context, HomeController controller) {
    return GestureDetector(
      onTap: () {
        showOrderQRSlider(
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
            Get.to(() => OrderQRPage(
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
        S.edit_order,
        style: AppTextStyle.bold18().copyWith(color: appColors?.primary),
      ),
    );
  }
}
