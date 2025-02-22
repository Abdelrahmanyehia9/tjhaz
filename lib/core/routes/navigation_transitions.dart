import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page<dynamic> slidingTransition({required Widget child}) {
  return CustomTransitionPage(
    child: child,
    transitionDuration: Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1, 0), // Slide in from the right
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
