import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page<dynamic> fadingTransition({required Widget child}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
