import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';

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
          fixedSize: Size(screenWidth(context)*.4, 50.h),
          backgroundColor:isSkip == true?Colors.transparent:AppColors.secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child:  Text(isSkip==true? AppStrings.skip.toUpperCase(): AppStrings.next.toUpperCase(),
            style: isSkip == true ? AppTypography.t20Normal.copyWith(color: AppColors.cWhite) : AppTypography.t16Normal.copyWith(color: AppColors.cWhite))
    );
  }
}
