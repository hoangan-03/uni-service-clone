import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/gen/colors.gen.dart';

import '../gen/fonts.gen.dart';

class AppTextStyle {
  static TextStyle regular12({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w400, 12, color: color);
  }

  static TextStyle regular14({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w400, 14, color: color);
  }

  static TextStyle regular16({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w400, 16, color: color);
  }

  static TextStyle regular18({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w400, 18, color: color);
  }

  static TextStyle medium12({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 12, color: color);
  }

  static TextStyle medium14({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 14, color: color);
  }

  static TextStyle medium16({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 16, color: color);
  }

  static TextStyle medium18({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 18, color: color);
  }

  static TextStyle medium24({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 24, color: color);
  }

  static TextStyle medium32({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w500, 32, color: color);
  }

  static TextStyle bold12({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w700, 12, color: color);
  }

  static TextStyle bold14({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w700, 14, color: color);
  }

  static TextStyle bold16({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w700, 16, color: color);
  }

  static TextStyle bold18({Color color = ColorName.grayBase}) {
    return _styleWith(FontWeight.w700, 18, color: color);
  }

  static TextStyle _styleWith(
    FontWeight weight,
    double size, {
    Color? color,
    double? height,
    FontStyle style = FontStyle.normal,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontWeight: weight,
      fontSize: size,
      fontFamily: FontFamily.sFProDisplay,
      color: color,
      fontStyle: style,
      height: height,
      decoration: decoration,
    );
  }
}
