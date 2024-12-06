import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_constants.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';

class AccountInfoPage extends BaseGetView<AccountController> {
  const AccountInfoPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.of(context).account_info,
        appColors: appColors,
        hasBackButton: true,
      ),
      body: Stack(
        children: [
          Container(
            color: appColors!.white,
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final user = controller.user.value;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoField(
                        context,
                        S.of(context).enter_fullname,
                        user.username ?? '',
                        appColors,
                        (value) => user.username = value,
                        hintText: S.of(context).enter_fullname),
                    buildInfoField(
                        context,
                        S.of(context).enter_identity_card,
                        user.identificationCard ?? '',
                        appColors,
                        (value) => user.identificationCard = value,
                        hintText: S.of(context).enter_identity_card),
                    buildDatePickerField(
                      context,
                      S.of(context).birthday,
                      user.birthdate ?? '',
                      appColors,
                      (value) {
                        user.birthdate = value;
                        controller.user.refresh();
                      },
                      hintText: S.of(context).enter_birthday,
                    ),
                    buildInfoField(context, S.of(context).school, user.school ?? '',
                        appColors, (value) => user.school = value,
                        hintText: S.of(context).enter_school),
                    buildInfoField(context, S.of(context).faculty, user.faculty ?? '',
                        appColors, (value) => user.faculty = value,
                        hintText: S.of(context).enter_faculty),
                    buildInfoField(context, S.of(context).position, user.position ?? '',
                        appColors, (value) => user.position = value,
                        hintText: S.of(context).enter_position),
                    buildInfoField(context, S.of(context).role, user.role ?? '', appColors,
                        (value) => user.role = value,
                        hintText: S.of(context).enter_role),
                    buildInfoField(context, S.of(context).email, user.email ?? '',
                        appColors, (value) => user.email = value,
                        hintText: S.of(context).enter_email),
                    buildInfoField(context, S.of(context).phone_number, user.phone ?? '',
                        appColors, (value) => user.phone = value,
                        hintText: S.of(context).enter_phone_number),
                    const SizedBox(height: 80.0),
                  ],
                ),
              );
            }),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                final user = controller.user.value;
                controller.updateProfile(user);
                Get.back();
                buildSnackBar(S.of(context).update_success, true);
              },
              style: elevatedButtonStyle(context),
              child: Text(
                S.of(context).update_info,
                style: elevatedButtonTextStyle(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoField(BuildContext context, String label, String value,
      AppColors? appColors, Function(String) onChanged,
      {IconData? icon, required String hintText}) {
    final bool isDarkMode = Get.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular12().copyWith(color: appColors!.gray),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon:
                icon != null ? Icon(icon, color: appColors.secondary) : null,
            filled: true,
            fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
            constraints: BoxConstraints(
              maxHeight: 40.0,
              minHeight: 40.0,
            ),
          ),
          style: AppTextStyle.regular12().copyWith(color: appColors.secondary),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildDatePickerField(BuildContext context, String label, String value,
      AppColors? appColors, Function(String) onChanged,
      {required String hintText}) {
    final bool isDarkMode = Get.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.regular12().copyWith(color: appColors!.gray),
        ),
        const SizedBox(height: 4.0),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate;
            try {
              pickedDate = value.isNotEmpty
                  ? AppConstants.dateFormat.parse(value)
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
              onChanged(AppConstants.dateFormat.format(selectedDate));
            }
          },
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: appColors.transparent),
            ),
            constraints: BoxConstraints(
              maxHeight: 40.0,
              minHeight: 40.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value.isNotEmpty ? value : hintText,
                  style: AppTextStyle.regular12()
                      .copyWith(color: appColors.secondary),
                ),
                Icon(Icons.calendar_today, color: appColors.secondary),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
