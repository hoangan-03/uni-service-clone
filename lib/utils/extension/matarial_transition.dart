import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MaterialMotionTransition extends PageRouteBuilder {
  final Widget page;

  MaterialMotionTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
        );
}