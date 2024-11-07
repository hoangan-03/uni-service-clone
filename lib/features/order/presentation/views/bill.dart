import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/format_price.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class BillPage extends BaseGetView<HomeController> {
  final String name;
  final String description;
  final int quantity;
  final int totalPrice;
  final String branch;

  const BillPage({
    Key? key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.totalPrice,
    required this.branch,
  }) : super(key: key);

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hoá đơn',
          textAlign: TextAlign.center,
          style: AppTextStyle.bold20().copyWith(color: appColors?.secondary),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Text(
              'Ngày hết hạn: 23:00 - 18/04/2023',
              style: AppTextStyle.regular14().copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: appColors?.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Đã giao hàng',
                style: AppTextStyle.bold14().copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16.0),
            Image.network(
              'https://cdn.britannica.com/17/155017-050-9AC96FC8/Example-QR-code.jpg', // Sample QR image URL
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 8.0),
            Text(
              '18:32 - 22/03/2023',
              style: AppTextStyle.regular12().copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Mã hoá đơn : MDSHFJKJKSHADJKASLKJSDJKL',
              style: AppTextStyle.regular14().copyWith(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Thông tin đơn hàng',
              style: AppTextStyle.bold16().copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://cdn.mos.cms.futurecdn.net/FRdq8ZbPetwNDRV9R3hYpP.jpg',
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
                Column(
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
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8.0),
            Row(
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
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
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
            ),
          ],
        ),
      ),
    );
  }
}
