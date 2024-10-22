import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_v2/app.dart';
import 'package:flutter_base_v2/base/data/base_repo.dart';
import 'package:flutter_base_v2/utils/config/app_config.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  initializeJsonMapper();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await AppConfig.loadEnv();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  Get.put(LocalStorage(), permanent: true);
  runApp(MyApp(Get.find()));
}
