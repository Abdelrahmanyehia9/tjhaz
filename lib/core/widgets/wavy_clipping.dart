import 'package:flutter/material.dart';
import '../../../../core/styles/colors.dart';

class WavyClipping extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primaryColor;// Dark blue color

    Path path = Path();
    path.moveTo(0, size.height);

    // First curve on the left
    path.quadraticBezierTo(
        size.width * 0.05, size.height * 0.85, size.width * 0.25,
        size.height * 0.85);

    // Straight line in the middle
    path.lineTo(size.width *.6, size.height * 0.85);

    // Second curve on the right
    path.quadraticBezierTo(
        size.width , size.height * 0.85, size.width, size.height * 0.65);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}