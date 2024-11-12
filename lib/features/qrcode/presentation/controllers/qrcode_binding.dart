import 'package:flutter_base_v2/features/qrcode/presentation/controllers/qrcode_controller.dart';
import 'package:get/get.dart';

class QrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrcodeController());
  }
}
