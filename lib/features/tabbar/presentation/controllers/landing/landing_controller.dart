import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:get/get.dart';
import 'package:flutter_base_v2/features/home/presentation/utils/snackbar.dart';
class LandingController extends BaseController {
  String appVersion = '1.1.1';

  LandingController();

  void toLogin() {
    N.toLogin();
  }

  void toRegister() {
    // N.toRegister();
     buildSnackBar("Coming soon", false);
  }

  void toUniLogin() {
    N.toUniLoginPage();
  }
}
