import 'package:flutter_base_v2/features/branch/domain/usecases/get_branch_uc.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_controller.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:flutter_base_v2/features/home/domain/usecases/profile/get_profile_uc.dart';
import 'package:get/get.dart';

class BranchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BranchController());

    Get.lazyPut(() => GetBranchUseCase(Get.find()));
  }
}
