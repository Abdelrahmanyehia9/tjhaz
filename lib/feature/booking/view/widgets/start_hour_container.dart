import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class StartingHourContainer extends StatelessWidget {
  final bool isSelected;
  final int time;
  final bool isAvailable;

  const StartingHourContainer({super.key ,   required this.isSelected , required this.time , required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      width: 75.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryColor
              : Color(0xffE0E0E0).withOpacity(0.46),
          borderRadius: BorderRadius.circular(8),
          border: isAvailable ? Border.all(color: AppColors.secondaryColor) : null
      ),
      child:  Text(
        newTime(time)     ,
        style: AppTypography.t12Bold.copyWith(
            color:
            isSelected ? Colors.white : AppColors.secondaryColor),
      ),
    );
  }

  String newTime(int time) {
    String fixedTime = "" ;
    if (time >= 12) {
      int hour = (time > 12) ? time - 12 : 12;
      fixedTime  = "${hour.toString().padLeft(2, '0')}:00 ِAM";
    } else {
      int hour = (time == 0) ? 12 : time;
      fixedTime = "${hour.toString().padLeft(2, '0')}:00 PM";
    }

    return fixedTime ;

  }
}
