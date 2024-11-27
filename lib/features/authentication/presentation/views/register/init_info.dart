import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/authentication/data/args/token_input.dart';
import 'package:flutter_base_v2/features/authentication/presentation/controllers/register/register_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InitInfoPage extends BaseGetView<RegisterController> {
  const InitInfoPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final TokenInput token = Get.arguments as TokenInput;

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
              final user = controller.userInitInfo.value;
              controller.initProfile(user);
              buildSnackBar(S.success_register, true);
              N.toBranchPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: appColors!.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              S.continue_text,
              style: AppTextStyle.bold14().copyWith(
                color: appColors.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoField(BuildContext context, String label, String value,
      AppColors? appColors, Function(String) onChanged,
      {IconData? icon, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular14().copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon:
                icon != null ? Icon(icon, color: appColors?.secondary) : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppTextStyle.regular14().copyWith(color: Colors.black),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildDatePickerField(BuildContext context, String label, String value,
      AppColors? appColors, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular14().copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4.0),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate;
            try {
              pickedDate = value.isNotEmpty
                  ? DateFormat('dd/MM/yyyy').parse(value)
                  : DateTime.now();
            } catch (e) {
              pickedDate = DateTime.now();
            }

            final selectedDate = await showDatePicker(
              context: context,
              initialDate: pickedDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (selectedDate != null) {
              onChanged(DateFormat('dd/MM/yyyy').format(selectedDate));
            }
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.isNotEmpty ? value : S.enter_birthday,
                  style: AppTextStyle.regular14().copyWith(color: Colors.black),
                ),
                Icon(Icons.calendar_today, color: appColors?.secondary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
