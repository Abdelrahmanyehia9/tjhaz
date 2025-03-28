import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class AppBackButton extends StatelessWidget {
  final TextStyle? textStyle;
  final double? iconSize;
  const AppBackButton({super.key, this.iconSize, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
          context.pop();

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back,
              color: AppColors.secondaryColor,
              size: iconSize?.sp ?? 24.sp,
            ),
            horizontalSpace(4),
            Text(
              AppStrings.back,
              style: textStyle ?? AppTypography.t12Bold.copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
      )
    );
  }

}
