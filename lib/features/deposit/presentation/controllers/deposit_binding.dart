import 'package:flutter_base_v2/features/deposit/domain/usecases/deposit_uc.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_controller.dart';
import 'package:get/get.dart';

class DepositBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DepositController.new);
    Get.lazyPut(() => DepositRequestUseCase(Get.find()));

  }
}
