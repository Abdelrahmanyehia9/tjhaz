import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';
import '../utils/screen_size.dart';

class FixedBottomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child ;
  final  String? title ;
  const FixedBottomButton({super.key , required this.onPressed  , this.child , this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(screenWidth(context), 75.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: AppColors.secondaryColor
      ),
      child: child ?? Text(title??AppStrings.bookNow , style: AppTypography.t20Normal.copyWith(color: AppColors.cWhite),),
    );
  }
}
