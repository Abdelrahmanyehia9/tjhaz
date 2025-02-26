import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/app_gradient.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/box_action_button.dart';
import 'package:tjhaz/feature/shop/view/widget/product_quantiy.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: CardSizes.productCard.width,
          height: CardSizes.productCard.height,
          decoration: BoxDecoration(
            gradient: AppGradient.productCardGradient,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                      width: 151.w,
                      height: 120.h,
                      child: Image.network(
                        "https://m.media-amazon.com/images/I/51lTCyB0dsL._AC_UF894,1000_QL80_.jpg",
                        fit: BoxFit.cover,
                      )),
                ),
                Spacer(),
                Text(
                  "WATER WALKWAT".toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.t12Bold
                      .copyWith(color: AppColors.primaryColor),
                ),
                verticalSpace(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("89.50 KWD",
                        style: AppTypography.t11Normal
                            .copyWith(color: AppColors.primaryColor)),
                    ProductQuantity(),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        Positioned(
            top: 12.h,
            right: 12.h,
            child: BoxIconButton(
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
                  style:
                      AppTypography.t11Bold.copyWith(color: AppColors.cWhite),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
