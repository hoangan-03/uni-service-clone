import 'package:flutter_base_v2/features/example_list/domain/usecases/get_list_history_uc.dart';
import 'package:flutter_base_v2/features/example_list/presentation/controllers/example_list_controller.dart';
import 'package:get/get.dart';

class ExampleListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => GetListHistoryUseCase(Get.find()),
    );
    Get.lazyPut(() => ExampleListController());
  }
}
