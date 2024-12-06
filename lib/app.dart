import 'package:flutter/material.dart';
import 'package:flutter_base_v2/base/data/local/local_storage.dart';
import 'package:flutter_base_v2/features/authentication/data/providers/local/local_storage_ex.dart';
import 'package:flutter_base_v2/generated/l10n.dart';
import 'package:flutter_base_v2/utils/config/app_binding.dart';
import 'package:flutter_base_v2/utils/config/app_route.dart';
import 'package:flutter_base_v2/utils/config/app_theme.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp(this._localStorage, {super.key});

  final LocalStorage _localStorage;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Uni Service Clone',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.root,
      initialBinding: AppBinding(),
      getPages: AppRoute.generateGetPages,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _localStorage.themeMode,
      locale: _localStorage.locale != null ? Locale(_localStorage.locale!) : null,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

