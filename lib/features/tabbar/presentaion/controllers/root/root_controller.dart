import 'package:flutter_base_v2/base/presentation/base_controller.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/auth_service.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class RootController extends BaseController {
  final AuthService _authService;

  RootController(this._authService);

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      // Handle transition
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

  void _handleAuthenticated() {
    // N.toBranchPage();
    N.toHome(input: HomeInput('Vinh Truong', 'vinhthv1@yopmail.com'));
    Future.delayed(
        const Duration(milliseconds: 100), FlutterNativeSplash.remove);
  }

  void _handleUnauthenticated() {
    _authService.logout().then((_) {
      Future.delayed(
          const Duration(milliseconds: 100), FlutterNativeSplash.remove);
    });
  }
}
