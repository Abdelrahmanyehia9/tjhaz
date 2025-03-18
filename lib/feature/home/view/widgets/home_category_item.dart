import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/app_gradient.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class HomeCategoryItem extends StatelessWidget {
  final String imgUrl ;
  final String title ;
  const HomeCategoryItem({super.key, required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 75.w,
          height: 75.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: AppGradient.mainCategoriesGradient,
          ),
          child: SvgPicture.asset(imgUrl),
        ),
        verticalSpace(2),
        Text(
          title.toUpperCase(),
          style: AppTypography.t12Bold.copyWith(color: AppColors.primaryColor),
        )
      ],
    );
  }
}
