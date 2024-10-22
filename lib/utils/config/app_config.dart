import 'package:flutter_base_v2/utils/config/env/app_env.dart';
import 'package:flutter_base_v2/utils/config/env/dev_env.dart';
import 'package:flutter_base_v2/utils/config/env/prod_env.dart';
import 'package:flutter_base_v2/utils/config/env/stg_env.dart';
import 'package:package_info_plus/package_info_plus.dart';

enum Enviroment { dev, stg, prod }

class AppConfig {
  static Enviroment env = Enviroment.dev;
  static AppEnv appEnv = DevEnv();
  static String baseUrl = '';
  static PackageInfo? _packageInfo;

  static Future<void> loadEnv() async {
    await _checkEnv();

    switch (env) {
      case Enviroment.dev:
        appEnv = DevEnv();
        print('appEnv = DevEnv();');
        break;
      case Enviroment.stg:
        appEnv = StgEnv();
        print('appEnv = StgEnv();');
        break;
      case Enviroment.prod:
        appEnv = ProdEnv();
        print('appEnv = ProdEnv();');
        break;
      default:
    }

    baseUrl = appEnv.baseUrl;
    print('baseUrl = $baseUrl');
  }

  static Future<void> _checkEnv() async {
    _packageInfo = await PackageInfo.fromPlatform();
    final packageName = _packageInfo?.packageName ?? '';
    try {
      if (packageName.contains(Enviroment.dev.name)) {
        env = Enviroment.dev;
        print('env = Enviroment.dev;');
      } else if (packageName.contains(Enviroment.stg.name)) {
        env = Enviroment.stg;
        print('env = Enviroment.stg;');
      } else {
        env = Enviroment.prod;
        print('env = Enviroment.prod;');
      }
    } catch (e) {
      env = Enviroment.dev;
      print('catch env = Enviroment.dev;');
    }
  }
}
