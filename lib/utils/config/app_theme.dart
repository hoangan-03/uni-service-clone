import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';
import 'package:get/get.dart';

// AppColors colors(context) => Theme.of(context).extension<AppColors>() ?? const AppColors();

// ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

AppColors colors =
    Get.context?.theme.extension<AppColors>() ?? const AppColors();

ColorScheme colorScheme =
    Get.context?.theme.colorScheme ?? const ColorScheme.light();

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorName.grayHigh70,
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        primary: Color.fromRGBO(66, 63, 255, 1),
        secondary: Colors.black,
        background: Color.fromRGBO(66, 63, 255, 0.08),
        gray: Color.fromRGBO(172, 172, 176, 1),
        white: Colors.white,
        transparent: Colors.transparent,
      ),
    ],
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorName.greenBase,
      onPrimary: Colors.white,
      secondary: ColorName.grayBase,
      onSecondary: ColorName.greenBase,
      error: ColorName.errorBackground,
      onError: ColorName.error,
      surface: Colors.white,
      onSurface: ColorName.grayLow10,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: ColorName.grayBase,
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        primary: Colors.blue,
        secondary: Colors.orange,
        gray: Colors.red,
      ),
    ],
    // colorScheme: const ColorScheme(
    //     brightness: Brightness.light,
    //     primary: ColorName.greenBase,
    //     onPrimary: Colors.white,
    //     secondary: ColorName.grayBase,
    //     onSecondary: ColorName.greenBase,
    //     error: ColorName.errorBackground,
    //     onError: ColorName.error,
    //     background: ColorName.grayBase,
    //     onBackground: Colors.white,
    //     surface: Colors.white,
    //     onSurface: ColorName.grayLow10),
  );
}

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color gray;
  final Color white;
  final Color transparent;

  const AppColors(
      {this.primary = Colors.white,
      this.secondary = Colors.white,
      this.gray = Colors.white,
      this.background = Colors.white, this.white =  Colors.white, this.transparent = Colors.transparent});

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? gray,
    Color? background,
    Color? white,
    Color? transparent,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      gray: gray ?? this.gray,
      background: background ?? this.background,
      white: white ?? this.white,
      transparent: transparent ?? this.transparent,
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
    );
  }
}
