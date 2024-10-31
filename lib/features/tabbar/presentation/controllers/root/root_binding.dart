import 'package:flutter_base_v2/features/tabbar/presentation/controllers/root/root_controller.dart';
import 'package:get/instance_manager.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootController(Get.find()));
  }
}
