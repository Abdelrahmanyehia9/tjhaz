import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_localization.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';

class ProductActionButtons extends StatelessWidget {
  final GestureTapCallback? addToCart ;
  final GestureTapCallback? buyNow ;

  const ProductActionButtons({super.key , this.addToCart , this.buyNow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0.h , bottom: 16.h),
      child:  Column(
        children: [
          productActionButton(title: AppLocalizationsString.addToCart , context: context , onPressed: (){}) ,
          verticalSpace(4) ,
          productActionButton(title: AppLocalizationsString.buyNow , context: context , onPressed: (){} ) ,
        ],
      ),
    );
  }
  Widget productActionButton({GestureTapCallback? onPressed ,required BuildContext context ,required String title})=>ElevatedButton(
    onPressed:  onPressed, // Disable button if isDisabled is true
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondaryColor, // Change color if disabled
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      fixedSize: Size(screenWidth(context), 50.h),
    ),
    child: Text(
      title,
      style: AppTypography.t16Normal.copyWith(color : AppColors.cWhite),
    ),
  );

}
