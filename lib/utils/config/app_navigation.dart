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

  // static void toRegister({RouteType type = RouteType.to}) {
  //   type.navigate(name: AppRoute.register);
  // }

  static void toHome({
    required HomeInput input,
    RouteType type = RouteType.offAll,
  }) {
    type.navigate(name: AppRoute.tabbar, arguments: input);
  }
}
