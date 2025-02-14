import 'package:flutter/material.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';
import 'header_painter.dart';

class AuthHeader extends StatelessWidget {
  final Widget tittle  ;
  final String? description ;
  const AuthHeader({super.key, required this.tittle,  this.description});

  @override
  Widget build(BuildContext context) {
    return    Column(

      children: [
        CustomPaint(
          painter: HeaderPainter(),
          child: SizedBox(
            width: double.infinity,
            height: screenHeight(context)*.48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                tittle ,
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(width: screenWidth(context)*.8,
                      child: Text(description??"" , textAlign: TextAlign.center , style: AppTypography.t12Normal.copyWith(color: AppColors.cWhite))),
                )


              ],
            ),
          ),
        ),
      ],
    ) ;
  }
}
