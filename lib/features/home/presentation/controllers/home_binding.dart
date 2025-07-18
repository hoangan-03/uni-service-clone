import 'package:flutter_base_v2/features/home/domain/usecases/get_menu.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:flutter_base_v2/features/branch/domain/usecases/get_branch_uc.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/add_cart_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/add_payment_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_cart_shipping_uc.dart';
import 'package:flutter_base_v2/features/order/domain/usecases/get_cart_uc.dart';
import 'package:flutter_base_v2/features/qrcode/domain/usecases/get_qr_code.dart';
import 'package:flutter_base_v2/features/transfer/domain/usecases/transfer_uc.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(HomeInput('')));
    Get.lazyPut(() => GetProfileUseCase(Get.find()));
    Get.lazyPut(() => GetBranchUseCase(Get.find()));
    Get.lazyPut(() => GetMenuUseCase(Get.find()));
    Get.lazyPut(() => GetCartUseCase(Get.find()));
    Get.lazyPut(() => AddCartUseCase(Get.find()));
    Get.lazyPut(() => AddPaymentUseCase(Get.find()));
    Get.lazyPut(() => GetCartShippingUseCase(Get.find()));
    Get.lazyPut(() => GetQrCodeUseCase(Get.find()));
    Get.lazyPut(() => TransferRequestUseCase(Get.find()));

    // Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
  }
}
