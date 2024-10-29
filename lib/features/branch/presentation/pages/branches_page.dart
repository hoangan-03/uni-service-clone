import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_controller.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
class BranchsPage extends BaseGetView<BranchController> {
  const BranchsPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 32.0),
               Text(
                'Chọn chi nhánh',
                style: AppTextStyle.bold20(),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: controller.getBranchsState.widget(
                  onLoading: const Center(child: CircularProgressIndicator()), 
                  onSuccess: (branches) {
                    return ListView.builder(
                      itemCount: branches?.length,
                      itemBuilder: (context, index) {
                        final branch = branches![index];
                        return Obx(() => ListTile(
                              title: Text(branch.name),
                              subtitle: branch.description.isNotEmpty
                                  ? Text(
                                      branch.description,
                                       style: AppTextStyle.regular12().copyWith(color: appColors?.gray), 
                                    )
                                  : null,
                              trailing: Radio<Branch>(
                                value: branch,
                                groupValue: controller.selectedBranch.value,
                                onChanged: (Branch? value) {
                                  if (value != null) {
                                    controller.selectBranch(value);
                                  }
                                },
                                activeColor: appColors?.primary,
                              ),
                            ));
                      },
                    );
                  },
                  onError: (error) => Center(child: Text('Error: $error')), // Center the error message
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
              style: ElevatedButton.styleFrom(
                foregroundColor: appColors?.white,
                backgroundColor: appColors?.primary,
                minimumSize: const Size(double.infinity, 48),
              ),
              child:  Text(
                'Tiếp tục',
                style: AppTextStyle.bold18().copyWith(color: appColors?.white), 
              ),
            )),
      ),
    );
  }
}