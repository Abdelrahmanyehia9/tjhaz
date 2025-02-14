import 'package:flutter/material.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';

class OnBoardingButtons extends StatelessWidget {
  final  VoidCallback  onPressed ;
  final bool? isSkip ;
  const OnBoardingButtons({super.key , required this.onPressed , this.isSkip});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          fixedSize: Size(screenWidth(context)*.4, 50),
          backgroundColor:isSkip == true?Colors.transparent:AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:  Text(isSkip==true? "SKIP": "NEXT",
            style: isSkip == true ? AppTypography.t20Normal.copyWith(color: AppColors.cWhite) : AppTypography.t16Normal.copyWith(color: AppColors.cWhite))
    );
  }
}
