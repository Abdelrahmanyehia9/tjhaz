import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class RectangularCategory extends StatelessWidget {
  final String name ;
  final String img ;
  final bool? isActive ;
  const RectangularCategory({super.key ,required this.name , required this.img  , this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        verticalSpace(2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(name.tr().toUpperCase() , style: AppTypography.t14Normal.copyWith(color: AppColors.primaryColor), ),
        )
      ],
    ) ;
  }
}
