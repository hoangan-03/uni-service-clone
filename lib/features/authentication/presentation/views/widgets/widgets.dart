import 'package:flutter/material.dart';
import 'package:flutter_base_v2/utils/gen/assets.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'widgets.g.dart';

@swidget
Widget appLogo() {
  return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: Assets.images.splashIcon.image().image)));
}
