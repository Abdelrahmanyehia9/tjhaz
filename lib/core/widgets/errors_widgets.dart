import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';
import '../utils/app_strings.dart';
import '../utils/constants.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: screenHeight(context)*.3,
                child: SvgPicture.asset(isDisconnected == true  ? AppConstants.disconnected : AppConstants.error )) ,
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
  const EmptyList({super.key , required this.title});

  @override
  Widget build(BuildContext context) {
    return  Column(

      children: [

        SizedBox(
            height: screenHeight(context)*.3,
            child: SvgPicture.asset(AppConstants.empty)) ,
        Text.rich(
          textAlign: TextAlign.center,
          style: AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),
          TextSpan(
              text: AppStrings.sorry,
              children: [
                TextSpan(
                  text: "$title ",
                ),
                TextSpan(
                  text: AppStrings.notAvailableStayTuned,
                ),
              ]
          ),


        )



      ],
    );
  }
}
