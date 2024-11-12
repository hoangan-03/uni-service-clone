import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/tabbar/tabbar_page.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillPage extends BaseGetView<HomeController> {
  final String name;
  final String description;
  final int quantity;
  final int totalPrice;
  final String branch;
  final String imageUrl;

  const BillPage({
    super.key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.totalPrice,
    required this.branch,
    required this.imageUrl,
  });

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: _buildAppBar(appColors, context),
      body: _buildBody(context, appColors),
    );
  }

  AppBar _buildAppBar(AppColors? appColors, BuildContext context) {
    return AppBar(
      title: Text(
        'Hoá đơn',
        textAlign: TextAlign.center,
        style: AppTextStyle.bold20().copyWith(color: appColors?.secondary),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Container _buildBody(BuildContext context, AppColors? appColors) {
    final String currentTime =
        DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now());
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          _buildExpirationDate(),
          const SizedBox(height: 8.0),
          _buildOrderStatusButton(appColors),
          const SizedBox(height: 16.0),
          _buildQRCodeImage(),
          const SizedBox(height: 8.0),
          _buildBillTimestamp(currentTime),
          const SizedBox(height: 8.0),
          _buildBillId(),
          const SizedBox(height: 16.0),
          _buildOrderDetailsHeader(),
          const SizedBox(height: 8.0),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 8.0),
          _buildOrderItemDetails(),
          const SizedBox(height: 16.0),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 8.0),
          _buildTotalPrice(appColors),
          const SizedBox(height: 16.0),
          _buildReturnHomeButton(appColors),
        ],
      ),
    );
  }

  Text _buildExpirationDate() {
    return Text(
      "Ngày hết hạn: ${DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now().add(const Duration(hours: 8)))}",
      style: AppTextStyle.regular14().copyWith(color: Colors.grey),
    );
  }

  ElevatedButton _buildOrderStatusButton(AppColors? appColors) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors?.onSuccess,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        'Chưa giao hàng',
        style: AppTextStyle.bold14().copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildQRCodeImage() {
    return Obx(() {
      final qrCode = controller.qrmenu.value.id;
      if (qrCode == null) {
        return const CircularProgressIndicator();
      } else {
        return QrImageView(
          data: qrCode,
          version: QrVersions.auto,
          size: 150.0,
          gapless: false,
          errorStateBuilder: (context, error) {
            return Center(
              child: Text(
                'Uh oh! Something went wrong...',
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      }
    });
  }

  Text _buildBillTimestamp(String currentTime) {
    return Text(
      currentTime,
      style: AppTextStyle.regular12().copyWith(color: Colors.grey),
    );
  }

  Widget _buildBillId() {
    return Obx(() {
      final billId = controller.qrmenu.value.id;
      return Text(
        'Mã hoá đơn : $billId',
        style: AppTextStyle.regular14().copyWith(color: Colors.black),
      );
    });
  }

  Text _buildOrderDetailsHeader() {
    return Text(
      'Chi tiết đơn hàng',
      style: AppTextStyle.bold16().copyWith(color: Colors.black),
    );
  }

  Row _buildOrderItemDetails() {
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
                style: AppTextStyle.bold14().copyWith(color: Colors.black),
              ),
              const SizedBox(height: 4.0),
              Text(
                description,
                style: AppTextStyle.regular12().copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
        _buildOrderItemPriceDetails(),
      ],
    );
  }

  Column _buildOrderItemPriceDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'x$quantity',
          style: AppTextStyle.regular14().copyWith(color: Colors.black),
        ),
        const SizedBox(height: 4.0),
        Text(
          '${formatPrice(totalPrice)} đ',
          style: AppTextStyle.bold14().copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Row _buildTotalPrice(AppColors? appColors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tổng cộng',
          style: AppTextStyle.bold16().copyWith(color: Colors.black),
        ),
        Text(
          '${formatPrice(totalPrice)} đ',
          style: AppTextStyle.bold16().copyWith(color: appColors?.primary),
        ),
      ],
    );
  }

  ElevatedButton _buildReturnHomeButton(AppColors? appColors) {
    return ElevatedButton(
      onPressed: () {
        controller.updateQuantity(0);
        controller.updateItemIndex(0);
        Get.to(() => TabbarPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: appColors?.primary ?? Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        'Quay về trang chủ',
        style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
      ),
    );
  }
}