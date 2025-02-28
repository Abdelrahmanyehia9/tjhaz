import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_localization.dart';

class DurationContainer extends StatelessWidget {
  final String pricePerHour;
  final bool isSelected;
  final String time;
  const DurationContainer({super.key, required this.pricePerHour, required this.isSelected, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        width: 76.w,
        height: 76.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryColor
              : Color(0xffE0E0E0).withOpacity(0.46),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time.length<2?"0$time".toUpperCase():time.toUpperCase(),
              style: AppTypography.t12Bold.copyWith(
                  color:
                  isSelected ? Colors.white : AppColors.secondaryColor),
            ),
            verticalSpace(4),
            Text(
              "$pricePerHour ${AppLocalizationsString.kwdCurrency}"
                  .toUpperCase(),
              style: AppTypography.t12Bold.copyWith(
                  color:
                  isSelected ? Colors.white : AppColors.secondaryColor),
            )
          ],
        ));
  }
}
