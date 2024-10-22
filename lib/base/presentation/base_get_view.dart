import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:get/get.dart';

abstract class BaseGetView<W extends BaseController> extends GetView<W> {
  const BaseGetView({super.key});

  @protected
  Widget myBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    controller.initDialog(context);

    return myBuild(context);
  }
}