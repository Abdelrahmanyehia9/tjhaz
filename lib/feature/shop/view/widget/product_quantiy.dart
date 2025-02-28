import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class ProductQuantity extends StatelessWidget {
  final double? size ;
  const ProductQuantity({super.key, this.size , });

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
            child: Icon(Icons.add, size: size ?? 12, color: AppColors.cWhite),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal:size!=null  ? size!*.5 :   6.0.w),
          child: Text("1",
              style: TextStyle(color: AppColors.primaryColor , fontSize: size  )),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.secondaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(Icons.remove, size:size?? 12, color: AppColors.cWhite),
          ),
        ),
      ],
    );
  }
}
