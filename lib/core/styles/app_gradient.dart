
import 'package:flutter/material.dart';

class AppGradient{
  static LinearGradient productCardGradient = LinearGradient(
  begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [Colors.transparent, Colors.black87]);
static LinearGradient tripCardGradient= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff103B53).withOpacity(0.44),
      Colors.white.withOpacity(0.2)
    ]


);
static LinearGradient mainCategoriesGradient= LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF9FCEE8).withOpacity(0.46),
      Color(0xFF103B53).withOpacity(0.2),
      // 33% Opacity

    ],
  ) ;




}