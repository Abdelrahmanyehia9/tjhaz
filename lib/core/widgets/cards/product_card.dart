import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/app_gradient.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/widgets/box_icon_button.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';
import 'package:tjhaz/feature/shop/view/widget/product_quantiy.dart';

import '../../../feature/shop/data/model/product_mode.dart';

class ProductCard extends StatelessWidget {
  final ProductModel productModel ;
  const ProductCard({super.key , required this.productModel});

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
                      child: CachedNetworkImageWidget(imgUrl: productModel.images.first)
                  ),
                ),
                Spacer(),
                Text(
                  productModel.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.t12Bold
                      .copyWith(color: AppColors.primaryColor),
                ),
                verticalSpace(2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("${productModel.price} ${AppStrings.kwdCurrency}",
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
        productModel.priceBeforeDiscount != null ? Positioned(
          top: 20.h,
          left: -50.w,
          child: Transform.rotate(
            angle: -0.7854,
            child: Container(
              width: 150.w,
              color: AppColors.secondaryColor,
              child: Center(
                child: Text(
                  "${((productModel.price/productModel.priceBeforeDiscount!)*100).toStringAsFixed(0)}% ${AppStrings.sale}".toUpperCase(),
                  style:
                      AppTypography.t11Bold.copyWith(color: AppColors.cWhite),
                ),
              ),
            ),
          ),
        ):SizedBox(),
      ],
    );
  }
}
