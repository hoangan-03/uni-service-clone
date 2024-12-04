import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';
import 'package:get/get.dart';

AppColors colors =
    Get.context?.theme.extension<AppColors>() ?? const AppColors();

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorName.grayHigh70,
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        primary: Color.fromRGBO(66, 63, 255, 1),
        secondary: Colors.black,
        background: Color.fromRGBO(66, 63, 255, 0.08),
        gray: Color.fromRGBO(172, 172, 176, 1),
        lightGray: Color.fromRGBO(242, 242, 247, 1),
        white: Colors.white,
        transparent: Colors.transparent,
        onSuccess: Color.fromRGBO(24, 162, 72, 1),
        onCancel: Color.fromRGBO(255, 59, 48, 1),
        constantWhite: Colors.white,
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorName.grayHigh70,
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        primary: Color.fromRGBO(74, 133, 255, 1),
        secondary: Colors.white,
        background: Color.fromRGBO(66, 63, 255, 0.24),
        // gray: Color.fromRGBO(172, 172, 176, 1),
        // gray: Colors.white,
        // lightGray: Color.fromRGBO(242, 242, 247, 1),
        gray: Color.fromRGBO(242, 242, 247, 1),
        lightGray: Color.fromRGBO(172, 172, 176, 1),
        white: Colors.black,
        transparent: Colors.transparent,
        onSuccess: Color.fromRGBO(24, 162, 72, 1),
        onCancel: Color.fromRGBO(255, 59, 48, 1),
        constantWhite: Colors.white,
      ),
    ],
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color gray;
  final Color lightGray;
  final Color white;
  final Color transparent;
  final Color onSuccess;
  final Color onCancel;
  final Color constantWhite;

  const AppColors({
    this.primary = Colors.white,
    this.secondary = Colors.white,
    this.gray = Colors.white,
    this.lightGray = Colors.white,
    this.background = Colors.white,
    this.white = Colors.white,
    this.transparent = Colors.transparent,
    this.onSuccess = Colors.white,
    this.onCancel = Colors.white,
    this.constantWhite = Colors.white,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? gray,
    Color? background,
    Color? lightGray,
    Color? white,
    Color? transparent,
    Color? onSuccess,
    Color? onCancel,
    Color? constantWhite,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      gray: gray ?? this.gray,
      background: background ?? this.background,
      lightGray: lightGray ?? this.lightGray,
      white: white ?? this.white,
      transparent: transparent ?? this.transparent,
      onSuccess: onSuccess ?? this.onSuccess,
      onCancel: onCancel ?? this.onCancel,
      constantWhite: constantWhite ?? this.constantWhite,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      gray: Color.lerp(gray, other.gray, t) ?? gray,
      background: Color.lerp(background, other.background, t) ?? background,
      lightGray: Color.lerp(lightGray, other.lightGray, t) ?? lightGray,
      white: Color.lerp(white, other.white, t) ?? white,
      transparent: Color.lerp(transparent, other.transparent, t) ?? transparent,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      onCancel: Color.lerp(onCancel, other.onCancel, t) ?? onCancel,
      constantWhite: Color.lerp(constantWhite, other.constantWhite, t) ?? constantWhite,
    );
  }
}