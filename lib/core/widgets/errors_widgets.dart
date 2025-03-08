import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';
import '../utils/app_strings.dart';
import '../utils/app_assets.dart';
import '../utils/screen_size.dart';

class AppErrorWidget extends StatelessWidget {
  final bool? isDisconnected ;
  final String? error ;
  const AppErrorWidget({super.key ,  this.error , this.isDisconnected}) ;

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding:  EdgeInsets.all(18.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: screenHeight(context)*.3,
                child: SvgPicture.asset(isDisconnected == true  ? AppAssets.disconnected : AppAssets.error )) ,
            verticalSpace(16) ,
            Text(error == null ? AppStrings.somethingWentWrong:"$error ",overflow: TextOverflow.ellipsis,
              style: AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),)
          ],
        ),
      ),
    );
  }
}
class EmptyList extends StatelessWidget {
  final String title ;
  final IconData?  icon ;
  const EmptyList({super.key , required this.title , this.icon});

  @override
  Widget build(BuildContext context) {
    return  Column(
crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        icon ==null ? SizedBox(
            height: screenHeight(context)*.3,
            child: SvgPicture.asset(AppAssets.empty)) : Opacity(
          opacity: 0.5,
            child: Icon(icon , size: 150.sp , color: Color(0xfffffa994),)) ,
        verticalSpace(8) ,
        Text.rich(
          textAlign: TextAlign.center,
          style: AppTypography.t16Light.copyWith(color: AppColors.primaryColor),
          TextSpan(
              text: AppStrings.sorry.toUpperCase(),
              children: [
                TextSpan(
                  text: "$title ".toUpperCase(),
                ),
                TextSpan(
                  text: AppStrings.areEmpty.toUpperCase(),
                ),
              ]
          ),


        )



      ],
    );
  }
}
