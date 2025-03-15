import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/view/widgets/product_quantiy.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class CartItem extends StatelessWidget {
  final bool isSelected ;
  final CartModel cartModel ;
  const CartItem({super.key , this.isSelected = true   , required this.cartModel});

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
                          cartModel.itemImage
                          ,fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    horizontalSpace(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartModel.itemName.localized.toUpperCase(),
                          style: AppTypography.t12Bold
                              .copyWith(color: AppColors.primaryColor),
                        ),
                        Text(
                          "${cartModel.itemPrice} KWD".toUpperCase(),
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
                child: ProductQuantity(size: 12, cartModel: cartModel,),
              )
            ],
          )
        ],
      ),
    );
  }
}
