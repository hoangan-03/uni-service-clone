import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/controllers/root/root_controller.dart';

class RootPage extends BaseGetView<RootController> {
  const RootPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return const Scaffold();
  }
}
