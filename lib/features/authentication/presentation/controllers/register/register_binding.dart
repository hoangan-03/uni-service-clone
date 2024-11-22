import 'package:flutter_base_v2/features/authentication/domain/usecases/register/get_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/update_info_uc.dart';
import 'package:flutter_base_v2/features/authentication/domain/usecases/register/verify_otp_uc.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut(() => UpdateInfoUsecase(Get.find()));
    Get.lazyPut(() => GetOtpUsecase(Get.find()));
    Get.lazyPut(() => VerifyOtpUsecase(Get.find()));
  }
}
