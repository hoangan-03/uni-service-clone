import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_detail_uc.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:flutter_base_v2/features/transfer/presentation/controllers/transfer_controller.dart';
import 'package:get/get.dart';

class TransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(TransferController.new);
    Get.lazyPut(() => TransferRequestUseCase(Get.find()));
    Get.lazyPut(() => TransferDetailUseCase(Get.find()));
  }
}
