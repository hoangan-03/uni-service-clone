import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/utils/config/app_binding.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._localStorage, {super.key});

  final LocalStorage _localStorage;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Base v2',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.root,
      initialBinding: AppBinding(),
      getPages: AppRoute.generateGetPages,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _localStorage.themeMode,
    );
  }
}
