import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/tabbar/presentation/controllers/landing/landing_controller.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/gen/assets.gen.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';


class LandingPage extends BaseGetView<LandingController> {
  const LandingPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Assets.images.splashIcon.image().image,
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            // CupertinoButton(
            //   onPressed: controller.toTermsOfService,
            //   child: Text(
            //     S.current.terms,
            //   ),
            // ),
            // CupertinoButton(
            //   onPressed: controller.toPrivacyPolicy,
            //   child: Text(
            //     S.current.policy,
            //   ),
            // ),
            const SizedBox(
              height: 53,
            ),
            CommonButton(
              onPressed: controller.toRegister,
              fillColor: appColors!.primary,
              borderColor: appColors.primary,
              child: Text(
                S.register,
                style: AppTextStyle
                    .bold16()
                    .copyWith(color: appColors.white),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // CommonButton(
            //   onPressed: controller.toLogin,
            //   fillColor: Colors.transparent,
            //   borderColor: context.theme.primaryColor,
            //   child: Text(
            //     S.login,
            //     style: TextStyle(color: context.theme.colorScheme.primary),
            //   ),
            // ),
            // const SizedBox(
            //   height: 18,
            // ),
            CommonButton(
              onPressed: controller.toUniLogin,
              fillColor: appColors.transparent,
              borderColor: appColors.primary,
              child: Text(
               S.login,
                style: AppTextStyle
                    .bold16()
                    .copyWith(color: appColors.primary),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
             Text(
                controller.appVersion,
                style: AppTextStyle
                    .regular14()
                    .copyWith(color: appColors.secondary),
              ),
          ],
        ),
      ),
    );
  }
}
