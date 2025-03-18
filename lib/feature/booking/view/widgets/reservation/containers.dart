import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/typography.dart';
import '../../../../../core/utils/app_strings.dart';
///duration
class DurationContainer extends StatelessWidget {
  final int pricePerHour;
  final bool isSelected;
  final String time;

  const DurationContainer(
      {super.key,
      required this.pricePerHour,
      required this.isSelected,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        width: 76.w,
        height: 76.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryColor
              : const Color(0xffE0E0E0).withOpacity(0.46),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time.length < 2 ? "0$time".toUpperCase() : time.toUpperCase(),
              style: AppTypography.t12Bold.copyWith(
                  color: isSelected ? Colors.white : AppColors.secondaryColor),
            ),
            verticalSpace(4),
            Text(
              "${pricePerHour.toStringAsFixed(0)} ${AppStrings.kwdCurrency}"
                  .toUpperCase(),
              style: AppTypography.t12Bold.copyWith(
                  color: isSelected ? Colors.white : AppColors.secondaryColor),
            )
          ],
        ));
  }
}
///starting hour
class StartingHourContainer extends StatelessWidget {
  final bool isSelected;
  final String time;
  final bool isAvailable;
  final GestureTapCallback? onTap;

  const StartingHourContainer(
      {super.key,
      this.onTap,
      required this.isSelected,
      required this.time,
      required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: !isAvailable ? onTap : null,
      child: Container(
        alignment: Alignment.center,
        width: 75.w,
        height: 40.h,
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.secondaryColor
                : const Color(0xffE0E0E0).withOpacity(0.46),
            borderRadius: BorderRadius.circular(6.r),
            border: !isAvailable
                ? Border.all(color: AppColors.secondaryColor)
                : null),
        child: Text(
          time,
          style: AppTypography.t12Bold.copyWith(
              color: isSelected
                  ? Colors.white
                  : isAvailable
                      ? Colors.grey
                      : AppColors.secondaryColor),
        ),
      ),
    );
  }
}
/// crown booking all day
class BookingAllDayContainer extends StatelessWidget {
  final bool isSelected;
final int price ;
  const BookingAllDayContainer({super.key, required this.isSelected , required this.price});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          height: 92.h,
          width: 76.w,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          alignment: Alignment.center,
          width: 76.w,
          height: 76.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor ),
            color: isSelected
                ? AppColors.secondaryColor
                : const Color(0xffE0E0E0).withOpacity(0.46),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.allDay.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTypography.t10Normal.copyWith(
                  fontWeight: FontWeight.w900,
                    color:
                        isSelected ? AppColors.cWhite : AppColors.secondaryColor),
              ),
              Text(
                "$price ${AppStrings.kwdCurrency}",
                textAlign: TextAlign.center,
                style: AppTypography.t12Bold.copyWith(
                  fontWeight: FontWeight.w900,
                    color:
                        isSelected ? AppColors.cWhite : AppColors.secondaryColor),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
              height: 18.h,
              child: Image.asset(AppAssets.crownIcon ))
        ),
      ],
    );
  }
}
