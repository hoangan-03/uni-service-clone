import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/app_bar.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_controller.dart';
import 'package:flutter_base_v2/features/branch/domain/entities/branch.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';

class BranchsPage extends BaseGetView<BranchController> {
  const BranchsPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      backgroundColor: appColors?.white,
      appBar: buildAppBar(
        context: context,
        title: S.of(context).choose_branch,
        appColors: appColors,
        hasBackButton: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 6),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              Expanded(
                child: controller.getBranchsState.widget(
                  onLoading: const Center(child: CircularProgressIndicator()),
                  onSuccess: (branches) {
                    return ListView.builder(
                      itemCount: branches?.length,
                      itemBuilder: (context, index) {
                        final branch = branches![index];
                        return Obx(() => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectBranch(branch);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(branch.name,
                                                style: AppTextStyle.regular16()
                                                    .copyWith(
                                                        color: appColors
                                                            ?.secondary)),
                                            if (branch
                                                    .description?.isNotEmpty ==
                                                true)
                                              Text(
                                                branch.description ?? '',
                                                style: AppTextStyle.regular12()
                                                    .copyWith(
                                                        color: appColors?.gray),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Radio<Branch>(
                                        value: branch,
                                        groupValue:
                                            controller.selectedBranch.value,
                                        onChanged: (Branch? value) {
                                          if (value != null) {
                                            controller.selectBranch(value);
                                          }
                                        },
                                        activeColor: appColors?.primary,
                                        visualDensity: VisualDensity.compact,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      },
                    );
                  },
                  onError: (error) => Center(child: Text('Error: $error')),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => ElevatedButton(
              onPressed: controller.selectedBranch.value != null
                  ? controller.navigateToHome
                  : null,
              style: elevatedButtonStyle(context),
              child: Text(
                S.of(context).continue_text,
                style: elevatedButtonTextStyle(context),
              ),
            )),
      ),
    );
  }
}
