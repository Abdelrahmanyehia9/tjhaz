import 'package:flutter/material.dart';

class SlideFadeTransition extends StatelessWidget {
  final Widget child;
  final int index;
  final Duration duration;
  final double offsetY;

  const SlideFadeTransition({
    super.key,
    required this.child,
    required this.index,
    this.duration = const Duration(milliseconds: 500),
    this.offsetY = -30,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey<int>(index),
      duration: Duration(milliseconds: duration.inMilliseconds + (index * 100)),
      tween: Tween<double>(begin: offsetY, end: 0),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(
            opacity: (offsetY - value) / offsetY,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
