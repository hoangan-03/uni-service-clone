import 'package:flutter_base_v2/features/example_list/presentation/controllers/example_list_binding.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_binding.dart';
import 'package:get/get.dart';

class TabbarBinding extends Bindings {
  @override
  void dependencies() {
    HomeBinding().dependencies();
    ExampleListBinding().dependencies();
  }
}
