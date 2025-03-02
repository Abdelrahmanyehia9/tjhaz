import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/app_back_button.dart';

class ReservationHeadline extends StatelessWidget {
  final String title ;
  const ReservationHeadline({super.key  , required this.title});

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
