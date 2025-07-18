import 'package:flutter_base_v2/features/qrcode/presentation/controllers/qrcode_controller.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_detail_uc.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:get/get.dart';

class QrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrcodeController());

    Get.lazyPut(() => TransferController());
    Get.lazyPut(() => TransferRequestUseCase(Get.find()));
    Get.lazyPut(() => TransferDetailUseCase(Get.find()));
  }
}
