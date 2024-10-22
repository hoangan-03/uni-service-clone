import 'package:envied/envied.dart';
import 'package:flutter_base_v2/utils/config/env/app_env.dart';

part 'prod_env.g.dart';

@Envied(name: 'Env', path: 'assets/env/.env.prod',obfuscate: true)
class ProdEnv implements AppEnv {
  @override
  @EnviedField(varName: 'BASE_URL')
  final String baseUrl = _Env.baseUrl;

}