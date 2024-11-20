import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/controllers/qrcode_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRPage extends BaseGetView<QrcodeController> {
  const QRPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final QrcodeController controller = Get.put(QrcodeController());
    controller.requestPermission();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratioScanline = 300.0 / 375.0;
    double opacity = 0.2;
    double heightScanLine = width * ratioScanline;

    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      backgroundColor: appColors?.secondary,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: FractionalOffset.center,
        children: [
          Obx(() => (controller.isAllowCameraPermission.value)
              ? QRView(
                  key: qrKey,
                  onQRViewCreated: controller.onQRViewCreated as QRViewCreatedCallback,
                  overlay: QrScannerOverlayShape(
                    overlayColor: appColors!.transparent,
                    borderColor: appColors.transparent,
                    cutOutWidth: width,
                    cutOutHeight: height,
                  ),
                )
              : SizedBox(width: width, height: height)),
          Column(
            children: [
              Expanded(
                child:
                    Container(color: appColors?.secondary.withOpacity(opacity)),
              ),
              SizedBox(
                height: heightScanLine,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: appColors?.secondary.withOpacity(opacity),
                      ),
                    ),
                    Image.asset(
                      'assets/images/scan.png',
                      width: heightScanLine,
                      height: heightScanLine,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Container(
                          color: appColors?.secondary.withOpacity(opacity)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: appColors?.secondary.withOpacity(opacity),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: controller.closeScanQR,
                        icon: Icon(Icons.close, color: appColors?.white),
                      ),
                      Text(
                        'Quét mã QR',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bold18()
                            .copyWith(color: appColors?.white),
                        maxLines: 2,
                      ),
                      SizedBox(width: 48),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
