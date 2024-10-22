import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';
import 'package:get/get.dart';

class HomePage extends BaseGetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Home',
        leading: null,
        actions: [
          IconButton(
              onPressed: controller.logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => Text(
                      'Welcome ${controller.user.value.name}',
                      style: AppTextStyle.medium16(),
                    )),
                const SizedBox(height: 16),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.getProfile,
                    child: Text(
                      'Call API Get profile',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.setAccessToken,
                    child: Text(
                      'Clear access token',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.setRefreshToken,
                    child: Text(
                      'Clear refresh token',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.clearAllData,
                    child: Text(
                      'Clear local token',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.printFcmToken,
                    child: Text(
                      'Print FCM token',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.showNotifications,
                    child: Text(
                      'Show notifications',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                            padding: const EdgeInsets.all(16),
                            height: 150,
                            // color: Colors.greenAccent,
                            decoration: ShapeDecoration(
                              color: colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                            ),
                            child: Column(
                              children: [
                                CommonButton(
                                    fillColor: colorScheme.primary,
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Close',
                                      style: AppTextStyle.regular14(
                                          color: colorScheme.onPrimary),
                                    )),
                              ],
                            )),
                        barrierColor: Colors.black.withOpacity(0.2),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(35),
                        //   side: BorderSide(width: 5, color: Colors.black),
                        // ),
                      );
                    },
                    child: Text(
                      'Show bottom sheet',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colorScheme.primary,
                    onPressed: controller.printIcons,
                    child: Text(
                      'Print icons assets',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
                const SizedBox(height: 8),
                CommonButton(
                    fillColor: colors.color1,
                    onPressed: controller.switchTheme,
                    child: Text(
                      'Switch theme',
                      style:
                          AppTextStyle.regular14(color: colorScheme.onPrimary),
                    )),
              ]),
        ),
      ),
    );
  }
}
