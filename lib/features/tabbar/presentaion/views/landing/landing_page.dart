import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/controllers/landing/landing_controller.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/gen/assets.gen.dart';
import 'package:flutter_base_v2/utils/config/app_strings.dart';
import 'package:get/get.dart';

class LandingPage extends BaseGetView<LandingController> {
  const LandingPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
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
              fillColor: context.theme.primaryColor,
              borderColor: context.theme.primaryColor,
              child: Text(
                S.register,
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
            const SizedBox(
              height: 18,
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
              fillColor: Colors.transparent,
              borderColor: context.theme.primaryColor,
              child: Text(
                'Uni Login',
                style: TextStyle(color: colorScheme.primary),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              controller.appVersion,
            ),
          ],
        ),
      ),
    );
  }
}
