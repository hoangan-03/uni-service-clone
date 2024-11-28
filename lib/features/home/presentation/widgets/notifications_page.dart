import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/presentation/widgets/common.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Notifications',
      ),
    );
  }
}