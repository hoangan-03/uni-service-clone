import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

enum TabType { home, add, list }

class TabbarController extends BaseController {
  final _tabController = PersistentTabController(initialIndex: 0);

  PersistentTabController get tabController => _tabController;

  TabbarController();

  void onTabSelected(int index) {
    
  }
}
