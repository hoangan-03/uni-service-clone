import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class RootController extends BaseController {
  final AuthService _authService;
  final LocalStorage _localStorage = Get.find();

  RootController(this._authService);

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      if (await _authService.isAuthenticated()) {
        _handleAuthenticated();
      } else {
        _handleUnauthenticated();
      }
    } catch (e) {
      L.error(e);
      _handleUnauthenticated();
    }
  }

  Future<void> _handleAuthenticated() async {
    final selectedBranchJson = await _localStorage.getString('selectedBranch');
    print('Selected branchh: $selectedBranchJson');
    if (selectedBranchJson != null) {
      N.toHome(input: HomeInput('Vinh Truong', 'vinhthv1@yopmail.com'));
    } else {
      N.toBranchPage();
    }
    Future.delayed(
      const Duration(milliseconds: 100),
      FlutterNativeSplash.remove,
    );
  }

  void _handleUnauthenticated() {
    _authService.logout().then((_) {
      Future.delayed(
        const Duration(milliseconds: 100),
        FlutterNativeSplash.remove,
      );
    });
  }
}
