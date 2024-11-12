import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/controllers/qrcode_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:permission_handler/permission_handler.dart';

class QRPage extends BaseGetView<QrcodeController> {
  const QRPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final QrcodeController controller = Get.put(QrcodeController());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double ratioScanline = 180.0 / 375.0;
    double opacity = 0.2;
    double heightScanLine = width * ratioScanline;

    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: FractionalOffset.center,
        children: [
          Obx(() => (controller.isAllowCameraPermission.value)
              ? QRView(
                  key: qrKey,
                  onQRViewCreated: controller.onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    overlayColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    cutOutWidth: width,
                    cutOutHeight: height,
                  ),
                )
              : SizedBox(width: width, height: height)),
          Column(
            children: [
              Expanded(
                child: Container(color: Colors.black.withOpacity(opacity)),
              ),
              SizedBox(
                height: heightScanLine,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(opacity),
                      ),
                    ),
                    Container(
                      width: heightScanLine,
                      height: heightScanLine,
                      color: Colors.red, // Replace with your scan line image
                    ),
                    Expanded(
                      child:
                          Container(color: Colors.black.withOpacity(opacity)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black.withOpacity(opacity),
                ),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: controller.closeScanQR,
                          icon: Icon(Icons.close, color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: controller.openGallery,
                          icon: Obx(() => recentImageGallery(
                              medium: controller.recentMedium.value)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 12, left: 16, right: 16, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Text(
                        'Read QR Code',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recentImageGallery({Medium? medium}) {
    if (medium == null) {
      return Icon(Icons.photo, color: Colors.white);
    } else {
      return FutureBuilder<Uint8List?>(
        future: medium.getThumbnail().then((value) => value as Uint8List?),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          } else {
            return Icon(Icons.photo, color: Colors.white);
          }
        },
      );
    }
  }
}
