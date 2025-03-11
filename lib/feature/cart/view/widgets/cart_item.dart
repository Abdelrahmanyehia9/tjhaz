import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../shop/view/widget/product_quantiy.dart';

class CartItem extends StatelessWidget {
  final bool isSelected ;
  const CartItem({super.key , this.isSelected = true});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: 2.0.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: isSelected == true ? AppColors.secondaryColor:AppColors.cMediumGrey, width: 1.25.w)),
            child: CircleAvatar(backgroundColor: isSelected == true ?  AppColors.secondaryColor : Colors.transparent),
          ),
          horizontalSpace(8),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                height: 90.h,
                width: 330.w,
                decoration: BoxDecoration(
                    border: isSelected == true ? Border.all(color: AppColors.secondaryColor) : null,
                    borderRadius: BorderRadius.circular(8.r) ,
                    color: Colors.white,
                    boxShadow: isSelected == false ?   [
                      BoxShadow(
                        color: AppColors.cLightGrey,
                        spreadRadius: 0.1,
                        blurRadius: 0.5,
                        offset: const Offset(0, 1), // changes position of shadow
                      ) ,
                    ] : []

                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Image.network(
                          "https://blackfinrods.com/cdn/shop/files/83a2a377aa88f329decd76c3c95a8284.jpg?v=1721878718&width=1440",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WATER WALKWAY".toUpperCase(),
                          style: AppTypography.t12Bold
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        Text(
                          "89.000 KWD".toUpperCase(),
                          style: AppTypography.t12Normal
                              .copyWith(color: AppColors.primaryColor),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h , horizontal: 12.w),
                child: ProductQuantity(size: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
