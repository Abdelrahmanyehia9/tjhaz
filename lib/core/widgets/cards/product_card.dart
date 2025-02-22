import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/app_gradient.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/box_action_button.dart';
import 'package:tjhaz/core/widgets/product_quantiy.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          width: CardSizes.productCard.width,
          height: CardSizes.productCard.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://m.media-amazon.com/images/I/519zDNyJ-KL.jpg"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppGradient.productCardGradient
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 8.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(4) ,
                  Text(
                    "WATER WALKWAT ".toUpperCase(),
                    style: AppTypography.t12Bold.copyWith(color: AppColors.cWhite),
                  ),
                  verticalSpace(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("89.50 KWD", style: AppTypography.t11Normal.copyWith(color: AppColors.cWhite)),
                      ProductQuantity(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 12.h,
            right: 12.h,
            child: BoxActionButton(
              icon: Icons.favorite,
              size: 16.sp,
            )),
        Positioned(
          top: 20.h,
          left: -50.w,
          child: Transform.rotate(
            angle: -0.7854,
            child: Container(
              width: 150.w,
              color: AppColors.secondaryColor,
              child: Center(
                child: Text(
                  "49% sale".toUpperCase(),
                  style: AppTypography.t11Bold.copyWith(color: AppColors.cWhite),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
