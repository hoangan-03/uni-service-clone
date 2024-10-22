import 'package:envied/envied.dart';
import 'package:flutter_base_v2/utils/config/env/app_env.dart';

part 'dev_env.g.dart';

@Envied(name: 'Env', path: 'assets/env/.env.dev',obfuscate: true)
class DevEnv implements AppEnv {
  @override
  @EnviedField(varName: 'BASE_URL')
  final String baseUrl = _Env.baseUrl;

}