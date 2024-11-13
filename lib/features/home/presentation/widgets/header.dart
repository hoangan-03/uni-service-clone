import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/truncate_text.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';

Widget buildHeader(BuildContext context) {
  final appColors = Theme.of(context).extension<AppColors>();
  final GetStorage localStorage = GetStorage(); 
  final AccountController accountController = Get.find<AccountController>();

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
          Obx(() {
            final user = accountController.user.value;
            return ClipOval(
              child: Image.network(
                user.avatar ?? 'https://img.freepik.com/free-vector/young-man-orange-hoodie_1308-175788.jpg?t=st=1729744242~exp=1729747842~hmac=5c6a50bb08d559044f0891ec88a4086c66abaa381f0922a63d75773caf9a534a&w=360',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 50);
                },
              ),
            );
          }),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                final user = accountController.user.value;
                return Text(
                  user.username ?? '',
                  style: AppTextStyle.bold16().copyWith(color: appColors?.secondary),
                );
              }),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.branch);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                  decoration: BoxDecoration(
                    color: appColors!.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: appColors!.gray, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: appColors.secondary, size: 16),
                      const SizedBox(width: 3),
                      Text(
                        truncateText(branchName, 30),
                        style: AppTextStyle.regular12().copyWith(color: appColors.secondary),
                      ),
                      const SizedBox(width: 3),
                      Icon(Icons.expand_more, color: appColors.secondary, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      IconButton(
        icon: Icon(FontAwesomeIcons.fileInvoice, color: appColors.secondary),
        onPressed: () {
          Get.toNamed(AppRoute.cartShipping);
        },
      ),
    ],
  );
}