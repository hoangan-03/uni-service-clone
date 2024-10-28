import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_controller.dart';
import 'package:flutter_base_v2/features/home/domain/entities/branch.dart';
import 'package:get/get.dart';

class BranchsPage extends BaseGetView<BranchController> {
  const BranchsPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: controller.getBranchsState.widget(
            onLoading: const CircularProgressIndicator(),
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
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
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
                          activeColor: const Color.fromRGBO(66, 63, 255, 1),
                        ),
                      ));
                },
              );
            },
            onError: (error) => Text('Error: $error'),
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
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(66, 63, 255, 1),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
      ),
    );
  }
}
