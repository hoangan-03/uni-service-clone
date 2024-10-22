import 'package:flutter_base_v2/features/authentication/domain/usecases/login/login_uc.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginWithEmailUseCase(Get.find()),
    );
    Get.lazyPut(
      () => LoginWithGoogleUseCase(Get.find()),
    );
    Get.lazyPut(
      () => LoginWithAppleUseCase(Get.find()),
    );
    Get.lazyPut(
      () => LoginController(Get.find(), Get.find(), Get.find()),
    );
  }
}
