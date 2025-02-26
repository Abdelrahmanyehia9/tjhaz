import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class OnboardingContent extends StatelessWidget {
  final String image, title;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        Container(
          padding:  EdgeInsets.symmetric(horizontal: 24.w , vertical: 24.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              verticalSpace(48),
              Text(
                  AppLocalizationsString.welcome,
                  style:  AppTypography.t20Bold.copyWith(color: AppColors.cWhite)
              ),
              verticalSpace(8),
              Text(
                  title.toUpperCase(),
                  style: AppTypography.t44Bold.copyWith(color: AppColors.cWhite , height: 0)
              ),
            ],
          ),
        ),
      ],
    );
  }
}