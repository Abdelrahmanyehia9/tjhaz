import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_strings.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class AppBackButton extends StatelessWidget {
  final TextStyle? textStyle;
  final double? iconSize;
  const AppBackButton({super.key, this.iconSize, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          // _closeApp();
        }
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
      ),
    );
  }

  void _closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // Closes the app on Android
    } else if (Platform.isIOS) {
      exit(0); // Closes the app on iOS
    }
  }
}
