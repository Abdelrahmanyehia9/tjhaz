import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String tittle;
  final bool isDisabled; // Optional parameter

  const AuthButton({
    super.key,
    required this.tittle,
    required this.onPressed,
    this.isDisabled = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 16.w),
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed, // Disable button if isDisabled is true
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? AppColors.cMediumGrey : AppColors.primaryColor, // Change color if disabled
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          fixedSize: Size(screenWidth(context), 50.h),
        ),
        child: Text(
          tittle,
          style: AppTypography.t16Normal.copyWith(color:isDisabled? AppColors.cDarkGrey: AppColors.cWhite),
        ),
      ),
    );
  }
}
