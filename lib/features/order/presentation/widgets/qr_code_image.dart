import 'package:flutter/material.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

Widget buildQRCodeImage(HomeController controller, AppColors appColors) {
    return Obx(() {
      final qrCode = controller.qrmenu.value.id;
      if (qrCode == null) {
        return const CircularProgressIndicator();
      } else {
        return QrImageView(
          data: qrCode,
          version: QrVersions.auto,
          backgroundColor: appColors.constantWhite,
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