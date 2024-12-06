import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_avatar.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_password_uc.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/update_profile_uc.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/account/domain/usecases/get_profile_uc.dart';
import 'package:get/get.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AccountController.new);
    Get.lazyPut(LocaleController.new);

    Get.lazyPut(() => GetProfileUseCase(Get.find()));
    Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
    Get.lazyPut(() => UpdateAvatarUseCase(Get.find()));
    Get.lazyPut(() => UpdatePasswordUseCase(Get.find()));
  }
}
