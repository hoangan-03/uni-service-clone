import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/helper/format_price.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/views/tabbar/tabbar_page.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
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
  final String branchName;

  const BillPage({
    super.key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.totalPrice,
    required this.branch,
    required this.imageUrl,
    required this.branchName,
  });

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: buildAppBar(
          appColors: appColors,
          context: context,
          title: S.bill,
          hasBackButton: false),
      body: _buildBody(context, appColors),
    );
  }

  Widget _buildBody(BuildContext context, AppColors? appColors) {
    final String currentTime =
        DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now());
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on,
                      color: appColors!.secondary, size: 16),
                  const SizedBox(width: 3.0),
                  Text(
                    branchName,
                    style: AppTextStyle.bold14()
                        .copyWith(color: appColors.secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            _buildExpirationDate(appColors),
            const SizedBox(height: 4.0),
            _buildOrderStatusButton(appColors),
            const SizedBox(height: 4.0),
            _buildQRCodeImage(),
            const SizedBox(height: 8.0),
            _buildBillTimestamp(currentTime),
            const SizedBox(height: 8.0),
            _buildBillId(),
            const SizedBox(height: 16.0),
            _buildOrderDetailsHeader(),
            const SizedBox(height: 4.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 6.0),
            _buildOrderItemDetails(),
            const SizedBox(height: 6.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 6.0),
            _buildTotalPrice(appColors),
            const SizedBox(height: 12.0),
            _buildReturnHomeButton(appColors),
          ],
        ),
      ),
    );
  }

  Text _buildExpirationDate(AppColors? appColors) {
    return Text(
      "${S.expired_date}${DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.now().add(const Duration(hours: 8)))}",
      style: AppTextStyle.bold12().copyWith(color: appColors!.secondary),
    );
  }

  ElevatedButton _buildOrderStatusButton(AppColors? appColors) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: appColors?.onSuccess,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        minimumSize: const Size(80, 30), 
      ),
      child: Text(
       S.not_delivered,
        style: AppTextStyle.bold12().copyWith(color: Colors.white),
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
              // child: Text(
              //   'Uh oh! Something went wrong...',
              //   textAlign: TextAlign.center,
              // ),
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
        '${S.bill_id}$billId',
        style: AppTextStyle.regular14().copyWith(color: Colors.black),
      );
    });
  }

  Text _buildOrderDetailsHeader() {
    return Text(
      S.order_detail,
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
          S.total_price,
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
        minimumSize: const Size (double.infinity, 40)

      ),
      child: Text(
       S.back_to_home,
        style: AppTextStyle.bold14().copyWith(color: appColors?.primary),
      ),
    );
  }
}