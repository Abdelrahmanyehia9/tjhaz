import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_strings.dart';

class HeadlineViewMore extends StatelessWidget {
  final String title ;
  final bool? hasViewMore;
  final GestureTapCallback? viewMoreOnTap;
  const HeadlineViewMore({super.key , required this.title  , this.hasViewMore  , this.viewMoreOnTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 8.0.h, bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toLowerCase(),
            style: AppTypography.t18Bold
                .copyWith(color: AppColors.secondaryColor),
          ),
          hasViewMore == true
              ? CustomGestureDetector(
            onTap:  viewMoreOnTap,
                child: Text(
                            AppStrings.viewAll.toUpperCase(),
                            style: AppTypography.t12Bold
                  .copyWith(color: AppColors.secondaryColor),
                          ),
              )
              : const SizedBox(),
        ],
      ),
    );
  }
}
