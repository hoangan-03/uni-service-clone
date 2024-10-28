import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter_base_v2/utils/config/app_text_style.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_controller.dart';


class BranchsPage extends BaseGetView{
  const BranchsPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Home',
        leading: null,
      ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: controller.getBranchsState.widget(
      //       onLoading: LoadingWidget(),
      //       onSuccess: (branchs) {
      //         return ListView.builder(
      //                       itemCount: branchs?.length ?? 0,
      //                       itemBuilder: (context, index) {
      //                         final branch = branchs![index];
      //                         return ListTile(
      //                           title: Text(branch.name),
      //                           subtitle: branch.description != ""
      //                               ? Text(
      //                                   branch.description,
      //                                   style: TextStyle(
      //                                     fontSize: 12,
      //                                     color: Colors.grey[600],
      //                                   ),
      //                                 )
      //                               : null,
      //                           // trailing: Radio<Branch>(
      //                           //   // value: branch,
      //                           //   // groupValue: selectedBranch,
      //                           //   // onChanged: (Branch? value) {
      //                           //   //   setState(() {
      //                           //   //     selectedBranch = value;
      //                           //   //   });
      //                           //   // },
      //                           //   activeColor: Color.fromRGBO(66, 63, 255, 1),
      //                           // ),
      //                         );
      //                       },
      //                     );

      //       }
      //     )
      //   ),
      // ),
    );
  }
}
