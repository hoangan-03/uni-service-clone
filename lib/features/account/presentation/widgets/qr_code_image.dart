import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

final controller = Get.find<AccountController>();

Widget buildQRCodeImage() {
    return Obx(() {
      final qrCode = "usr:${controller.user.value.id}";
      return QrImageView(
        data: qrCode,
        version: QrVersions.auto,
        size: 200.0,
        gapless: false,
        errorStateBuilder: (context, error) {
          return Center(
              // child: Text(
              //   'Có lỗi xảy ra...',
              //   textAlign: TextAlign.center,
              // ),
              );
        },
      );
    });
  }