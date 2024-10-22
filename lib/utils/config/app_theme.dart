import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';
import 'package:get/get.dart';

// AppColors colors(context) => Theme.of(context).extension<AppColors>() ?? const AppColors();

// ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

AppColors colors = Get.context?.theme.extension<AppColors>() ?? const AppColors();

ColorScheme colorScheme = Get.context?.theme.colorScheme ?? const ColorScheme.light();

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorName.grayHigh70,
    extensions: const <ThemeExtension<AppColors>>[
      AppColors(
        color1: Colors.cyan,
        color2: Colors.yellow,
        color3: Colors.pink,
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
          color1: Colors.blue,
          color2: Colors.orange,
          color3: Colors.red,
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
  final Color color1;
  final Color color2;
  final Color color3;

  const AppColors(
      {this.color1 = Colors.white,
      this.color2 = Colors.white,
      this.color3 = Colors.white});

  @override
  AppColors copyWith({
    Color? color1,
    Color? color2,
    Color? color3,
  }) {
    return AppColors(
      color1: color1 ?? this.color1,
      color2: color2 ?? this.color2,
      color3: color3 ?? this.color3,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      color1: Color.lerp(color1, other.color1, t) ?? color1,
      color2: Color.lerp(color2, other.color2, t) ?? color2,
      color3: Color.lerp(color3, other.color3, t) ?? color3,
    );
  }
}
