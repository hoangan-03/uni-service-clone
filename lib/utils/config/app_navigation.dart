import 'package:flutter_base_v2/features/authentication/data/args/email_input.dart';
import 'package:flutter_base_v2/features/authentication/data/args/token_input.dart';
import 'package:flutter_base_v2/features/deposit/presentation/controllers/deposit_input.dart';
import 'package:flutter_base_v2/features/home/presentation/controllers/home_input.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/utils/extension/route_type.dart';

class N {
  static void toNotifications({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.notifications);
  }

  static void toUniLoginPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.uniLogin);
  }

  static void toBranchPage({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.branch);
  }

  static void toLandingPage({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.landing);
  }

  static void toLogin({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.login);
  }

  static void toRegister({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.register);
  }

  static void toVerifyOtp({
    required EmailInput input,
    RouteType type = RouteType.to,
  }) {
    type.navigate(name: AppRoute.verifyOTP, arguments: input);
  }

  static void toInitInfo(
      {required TokenInput input, RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.initInfo, arguments: input);
  }

  static void toDeposit(
      {required DepositInput input, RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.deposit, arguments: input);
  }

  static void toAccount({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.tabbar, arguments: 4);
  }

  static void toHome({
    required HomeInput input,
    RouteType type = RouteType.offAll,
  }) {
    type.navigate(name: AppRoute.tabbar, arguments: 0);
  }

  static void toBranch({RouteType type = RouteType.offAll}) {
    type.navigate(name: AppRoute.branch);
  }

  static void toQrScanner({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.qr);
  }

  static void toAccountInfo({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.accountInfo);
  }

  static void toSetPin({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.setpinnumber);
  }

  static void toComfirmSetPin({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.confirmsetpinnumber);
  }

  static void toUpdatePin({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.updatepinnumber);
  }

  static void toConfromUpdatePin({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.confirmupdatepinnumber);
  }

  static void toSettings({RouteType type = RouteType.to}) {
    type.navigate(name: AppRoute.settings);
  }
}
