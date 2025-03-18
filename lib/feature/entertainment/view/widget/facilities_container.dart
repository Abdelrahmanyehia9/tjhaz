import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class FacilitiesContainer extends StatelessWidget {
  final bool? isComfort;
  final IconData icon ;
  final String title ;
  const FacilitiesContainer({super.key,required this.icon , required this.title , this.isComfort});

  @override
  Widget build(BuildContext context) {
    return  CustomGestureDetector(
      child: Container(
        width: isComfort==true?76.w: 104.w,height: 60.h,
        decoration: BoxDecoration(
            color: AppColors.cWhite,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 0.7 ,
                  blurRadius: 0.7 ,
                  offset: const Offset(0 , 1)
              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon , size: 26.sp,color: AppColors.primaryColor,) ,
            verticalSpace(2),
            Text(title.toUpperCase() ,textAlign: TextAlign.center , maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTypography.t10light.copyWith(color: AppColors.primaryColor),)
          ],
        ),
      ),
    ) ;();
  }
}
