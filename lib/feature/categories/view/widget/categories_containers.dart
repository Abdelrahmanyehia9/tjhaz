import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/icon_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class CircularCategory extends StatelessWidget {
  final String name;
  final bool? isActive ;
  const CircularCategory({super.key , required this.name , this.isActive});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: 76.w,height: 76.h,
          decoration: BoxDecoration(
            boxShadow:isActive ==true ? null : [
              BoxShadow(
                  color: Colors.grey.shade200 ,
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 3)
              )
            ],
            shape: BoxShape.circle ,
            color: isActive == true ? AppColors.secondaryColor : Colors.white,
          ),
          child: Icon(IconHelper.getCategoriesIcon(name) , color:isActive == true ?  Colors.white : AppColors.secondaryColor,size: 46.sp,),
        ),
        verticalSpace(4),
        Text(name.tr().toUpperCase() ,maxLines: 1 , overflow: TextOverflow.ellipsis , style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor),)
      ],
    );

  }
}

class RectangularCategory extends StatelessWidget {
  final String name ;
  final String img ;
  final bool? isActive ;
  final double spacing ;
  final CrossAxisAlignment crossAxisAlignment ;
  const RectangularCategory({super.key ,required this.name , required this.img  , this.isActive , this.crossAxisAlignment = CrossAxisAlignment.start  , this.spacing =  2 });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Container(
          width: 168.w,
          height: 76.h,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(img)),
              borderRadius: BorderRadius.circular(8) ,
              border: isActive == true ? Border.all(color: AppColors.secondaryColor , width: 2): null
          ),
        ),
        verticalSpace(spacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(name.toUpperCase() , style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor), ),
        )
      ],
    ) ;
  }
}
