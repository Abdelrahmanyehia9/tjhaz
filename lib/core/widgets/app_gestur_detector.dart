import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGestureDetector extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;

  const CustomGestureDetector({required this.child, this.onTap, super.key});

  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: widget.child
          .animate(target: _isPressed ? 1 : 0)
          .scaleXY(begin: 1, end: 0.92, duration: 100.ms, curve: Curves.linear)
          .fade(begin: 1.0, end: 0.5, duration: 100.ms, curve: Curves.linear),
    );
  }
}
