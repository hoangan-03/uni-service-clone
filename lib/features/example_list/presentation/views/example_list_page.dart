import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/base_get_view.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common_paged_list_view.dart';
import 'package:flutter_base_v2/features/example_list/domain/entities/history_paging.dart';
import 'package:flutter_base_v2/features/example_list/presentation/controllers/example_list_controller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExampleListPage extends BaseGetView<ExampleListController> {
  const ExampleListPage({super.key});

  @override
  Widget myBuild(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Example listd',
        leading: null,
      ),
      body: CommonPagedListView<History>(
        pagingController: controller.pagingController,
        itemBuilder: (context, history, index) {
          return Slidable(
              key: ValueKey(history.id),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    // An action can be bigger than the others.
                    flex: 2,
                    onPressed: (_) {},
                    backgroundColor: Color(0xFF7BC043),
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    label: 'Archive',
                  ),
                  SlidableAction(
                    onPressed: (_) {},
                    backgroundColor: Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.save,
                    label: 'Save',
                  ),
                ],
              ),
              child: SizedBox(
                height: 100,
                child: Center(
                  child: Text(history.id.toString()),
                ),
              ));
        },
      ),
    );
  }
}
