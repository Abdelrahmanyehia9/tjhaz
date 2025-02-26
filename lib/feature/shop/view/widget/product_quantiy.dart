import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.secondaryColor,
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 3.0.h , horizontal: 4.w),
            child: Icon(Icons.add, size: 12, color: AppColors.cWhite),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0.w),
          child: Text("1",
              style: AppTypography.t12Bold.copyWith(color: AppColors.primaryColor)),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.secondaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.remove, size: 12, color: AppColors.cWhite),
          ),
        ),
      ],
    );
  }
}
