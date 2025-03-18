import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';
import 'app_back_button.dart';

class AppHeadline extends StatelessWidget {
  final String tittle ;
  final TextStyle? textStyle ;
  final double topPadding ;
  const AppHeadline({super.key , required this.tittle , this.textStyle , this.topPadding= 16   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding.h, bottom: 10.h),
      child: Row(
        children: [
         context.canPop() ?   SizedBox(
           width: 60.w,
             child: const AppBackButton())  :SizedBox(
           width: 60.w,
         ),
          const Spacer(),
          SizedBox(
            width: 150.w,
            child: Text(
              tittle.toUpperCase(),
              textAlign: TextAlign.center,
              style:textStyle?? AppTypography.t20Bold
                  .copyWith(color: AppColors.secondaryColor),
            ),
          ),
          SizedBox(width: 60.w,) ,
          const Spacer()
        ],
      ),
    );
  }
}
