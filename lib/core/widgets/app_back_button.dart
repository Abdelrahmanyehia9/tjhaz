import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_localization.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

class AppBackButton extends StatelessWidget {
  final TextStyle? textStyle;
  final double? iconSize ;
  const AppBackButton({super.key , this.iconSize , this.textStyle });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pop();
      },
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back,
              color: AppColors.secondaryColor,
              size:iconSize?.sp?? 24.sp,
            ),
            horizontalSpace(4),
            Text(
              AppLocalizationsString.back,
              style: textStyle ?? AppTypography.t12Bold
                  .copyWith(color: AppColors.primaryColor),
            )
          ],
        ),
      ),
    )
    ;
  }
}
