import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';

import '../../../../core/widgets/app_gestur_detector.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String tittle;
  final bool isDisabled;
  final Color bgColor;

  const AuthButton({
    super.key,
    required this.tittle,
    required this.onPressed,
    this.isDisabled = false,
    this.bgColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 16.w),
      child: CustomGestureDetector(
        onTap: isDisabled ? null : onPressed,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisabled ? AppColors.cMediumGrey : bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            fixedSize: Size(screenWidth(context), 50.h),
          ),
          child: Text(
            tittle,
            style: AppTypography.t14Normal.copyWith(
              color: isDisabled ? AppColors.cDarkGrey : AppColors.cWhite,
            ),
          ),
        ),
      ),
    );
  }
}
