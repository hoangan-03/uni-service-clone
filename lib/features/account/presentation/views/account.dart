import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/account/presentation/controllers/account_controller.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/menu_items.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/profile_section.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/qr_code_image.dart';
import 'package:flutter_base_v2/features/account/presentation/widgets/qr_code_section.dart';
import 'package:flutter_base_v2/utils/config/app_svg_url.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';

class AccountPage extends BaseGetView<AccountController> {
  const AccountPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      backgroundColor: appColors!.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              buildProfileSection(context),
              const SizedBox(height: 10),
              buildQRSection(context),
              const SizedBox(height: 30),
              Column(
                children: [
                  buildMenuItem(
                      AppSvgUrl.icAccountInfo, SS.account_info, context,
                      onTap: () {
                    controller.navigateToAccountInfo();
                  }),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(AppSvgUrl.icSetting, SS.settings, context,
                      onTap: () {
                    controller.navigateToSettings();
                  }),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(
                      AppSvgUrl.icOpinion, SS.contribute_opinion, context,
                      onTap: () {
                    controller.navigateToSetPin();
                  }),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(AppSvgUrl.icContact, SS.contact_office, context),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(AppSvgUrl.icPrivacy, SS.privacy_policy, context),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(AppSvgUrl.icTerms, SS.terms_of_use, context),
                  Divider(color: appColors.lightGray),
                  buildMenuItem(AppSvgUrl.icLogout, SS.logout, context,
                      isLogout: true,
                      color: appColors.onCancel,
                      showTrailingIcon: false, onTap: () {
                    controller.logout();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
