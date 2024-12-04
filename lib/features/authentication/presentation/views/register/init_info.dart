import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/widgets/datepicker_field.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/widgets/info_field.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';

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
          title: S.register_info,
          appColors: appColors,
          hasBackButton: true,
        ),
        backgroundColor: appColors?.white,
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            final user = controller.userInitInfo.value;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoField(context, S.password, user.password, appColors,
                      (value) => user.password = value,
                      hintText: S.enter_password),
                  buildInfoField(context, S.expired_date, user.name, appColors,
                      (value) => user.name = value,
                      hintText: S.enter_display_name),
                  buildDatePickerField(
                    context,
                    S.birthday,
                    user.birthdate,
                    appColors,
                    (value) {
                      user.birthdate = value;
                      controller.userInitInfo.refresh();
                    },
                  ),
                  const SizedBox(height: 80.0),
                ],
              ),
            );
          }),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              controller.handleInit();
            },
            style: elevatedButtonStyle(context),
            child: Text(
              S.continue_text,
              style: elevatedButtonTextStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}
