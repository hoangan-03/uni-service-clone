import 'package:flutter_base_v2/features/home/domain/usecases/profile/get_profile_uc.dart';
import 'package:flutter_base_v2/features/branch/domain/usecases/get_branch_uc.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);

    Get.lazyPut(() => GetProfileUseCase(Get.find()));
    Get.lazyPut(()=> GetBranchUseCase(Get.find()));
  }
}
