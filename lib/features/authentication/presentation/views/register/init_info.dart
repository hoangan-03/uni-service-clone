import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';

class InitInfoPage extends BaseGetView<RegisterController> {
  const InitInfoPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();

    return GestureDetector(
      onTap: controller.hideKeyboard,
      child: Scaffold(
        appBar: buildAppBar(
          context: context,
          title: "Đăng ký thông tin",
          appColors: appColors,
          hasBackButton: true,
        ),
        backgroundColor: appColors?.white,
      ),
    );
  }
}
