import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/truncate_text.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_base_v2/features/order/presentation/views/cart_shipping.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';

Widget buildHeader(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  final GetStorage localStorage = GetStorage(); 

  final branchJson = localStorage.read('selectedBranch');
  String branchName = 'Sample name';

  if (branchJson != null) {
    final Map<String, dynamic> branchData = jsonDecode(branchJson);
    branchName = branchData['name'] ?? 'Sample'; 
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          ClipOval(
            child: Image.network(
              'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 50);
              },
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nguyễn Hoàng Ân',
                style: AppTextStyle.bold16().copyWith(color: appColors?.secondary),
              ),
              Text(
                truncateText(branchName, 30), 
                style: AppTextStyle.regular14(),
              ),
            ],
          ),
        ],
      ),
      IconButton(
        icon: Icon(Icons.notifications_outlined, color: appColors?.secondary),
        onPressed: () {
          Get.toNamed(AppRoute.cartShipping);
        },
      ),
    ],
  );
}