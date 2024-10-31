import 'package:flutter_base_v2/features/authentication/presentation/controllers/login/login_binding.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/login/login_page.dart';
import 'package:flutter_base_v2/features/authentication/presentation/views/login/uni_login_page.dart';
import 'package:flutter_base_v2/features/branch/presentation/controllers/branch_binding.dart';
import 'package:flutter_base_v2/features/branch/presentation/pages/branches_page.dart';
import 'package:flutter_base_v2/features/example_list/presentation/controllers/example_list_binding.dart';
import 'package:flutter_base_v2/features/example_list/presentation/views/example_list_page.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_binding.dart';
import 'package:flutter_base_v2/features/home/presentation/views/home_page.dart';
import 'package:flutter_base_v2/features/home/presentation/views/notifications_page.dart';
import 'package:flutter_base_v2/features/services/presentation/views/services.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/controllers/landing/landing_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/controllers/root/root_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/controllers/tabbar/tabbar_binding.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/views/landing/landing_page.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/views/root/root_page.dart';
import 'package:flutter_base_v2/features/tabbar/presentaion/views/tabbar/tabbar_page.dart';
import 'package:get/get.dart';

// Import the new pages
import 'package:flutter_base_v2/features/account/presentation/views/account.dart';
import 'package:flutter_base_v2/features/qrcode/presentation/views/qrcode.dart';
import 'package:flutter_base_v2/features/history/presentation/views/history.dart';

class AppRoute {
  static String root = '/';
  static String tabbar = '/tabbar';
  static String landing = '/landing';
  static String login = '/login';
  // static String register = '/register';

  static String exampleList = '/example_list';
  static String uniLogin = '/uni_login';
  static String notifications = '/notifications';
    static String home = '/home';
  static String service = '/service';
  static String qr = '/qr';
    static String history = '/history';
  static String account = '/account';
  static String branch = '/branches';


  static List<GetPage> generateGetPages = [
    GetPage(name: root, page: RootPage.new, binding: RootBinding()),
    GetPage(name: notifications, page: NotificationsPage.new),
    GetPage(
      name: landing,
      page: LandingPage.new,
      binding: LandingBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: login,
      page: LoginPage.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: home,
      page: HomePage.new,
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: exampleList,
      page: ExampleListPage.new,
      binding: ExampleListBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: tabbar,
      page: TabbarPage.new,
      binding: TabbarBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: uniLogin,
      page: UniLoginPage.new,
      binding: LoginBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
        name: branch,
        page: BranchsPage.new,
        binding: BranchBinding(),
        transition: Transition.noTransition),
            GetPage(name: service, page: ServicesPage.new),
    GetPage(name: qr, page: QRPage.new),
    GetPage(name: history, page: HistoryPage.new),
    GetPage(name: account, page: AccountPage.new),
  ];

  static GetPage? getPage(String name) {
    return generateGetPages.firstWhereOrNull((e) => e.name == name);
  }
}
