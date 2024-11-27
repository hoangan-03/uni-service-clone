import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/utils/helper/snackbar.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class AccountInfoPage extends BaseGetView<AccountController> {
  const AccountInfoPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: S.account_info,
        appColors: appColors,
        hasBackButton: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final user = controller.user.value;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoField(context, S.enter_fullname, user.username ?? '',
                        appColors, (value) => user.username = value, hintText: S.enter_fullname),
                    buildInfoField(context, S.enter_identity_card, user.identificationCard ?? '',
                        appColors, (value) => user.identificationCard = value, hintText: S.enter_identity_card),
                    buildDatePickerField(
                      context,
                      S.birthday,
                      user.birthdate ?? '',
                      appColors,
                      (value) {
                        user.birthdate = value;
                        controller.user.refresh();
                      },
                      hintText: S.enter_birthday,
                    ),
                    buildInfoField(context, S.school, user.school ?? '', appColors,
                        (value) => user.school = value, hintText: S.enter_school),
                    buildInfoField(context, S.faculty, user.faculty ?? '', appColors,
                        (value) => user.faculty = value, hintText: S.enter_faculty),
                    buildInfoField(context, S.position, user.position ?? '',
                        appColors, (value) => user.position = value, hintText: S.enter_position),
                    buildInfoField(context, S.role, user.role ?? '', appColors,
                        (value) => user.role = value, hintText: S.enter_role),
                    buildInfoField(context, S.email, user.email ?? '', appColors,
                        (value) => user.email = value, hintText: S.enter_email),
                    buildInfoField(context, S.phone_number, user.phone ?? '',
                        appColors, (value) => user.phone = value, hintText: S.enter_phone_number),
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
                buildSnackBar(S.update_success, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: appColors?.primary ?? Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                S.update_info,
                style: AppTextStyle.bold14().copyWith(
                  color: appColors?.primary,
                ),
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
      AppColors? appColors, Function(String) onChanged, {required String hintText}) {
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
                  value.isNotEmpty ? value : hintText,
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