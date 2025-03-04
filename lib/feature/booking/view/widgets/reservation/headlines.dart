import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/animation.dart';

import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/typography.dart';
import '../../../../../core/widgets/app_back_button.dart';

class ReservationAppBarHeadline extends StatelessWidget {
  final String title ;
  const ReservationAppBarHeadline({super.key  , required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, bottom: 10.h),
      child: Row(
        children: [
          AppBackButton(),
          Spacer(),
          Text(
            title.toUpperCase(),
            style: AppTypography.t20Normal.copyWith(color: AppColors.primaryColor),
          ),
          Spacer()
        ],
      ),
    );
  }
}
class ReservationHeadline extends StatelessWidget {
  final String text ;
  const ReservationHeadline({super.key ,required this.text});

  @override
  Widget build(BuildContext context) {
    return  SlideFadeTransition(
      index: 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          child: Text(
            text.toUpperCase(),
            style:
            AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
