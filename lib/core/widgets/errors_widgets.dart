import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/spacing.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';
import '../utils/app_strings.dart';
import '../utils/app_assets.dart';
import '../utils/screen_size.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AppErrorWidget extends StatelessWidget {
  final bool? isDisconnected;
  final String? error;

  const AppErrorWidget({super.key, this.error, this.isDisconnected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display either disconnected or error icon
          SizedBox(
            height: screenHeight(context) * 0.3,
            child: SvgPicture.asset(
              isDisconnected == true
                  ? AppAssets.disconnected
                  : AppAssets.error,
            ),
          ),
          // Vertical space between icon and text
          verticalSpace(16),
          // Error message text
          Text(
            error ?? AppStrings.somethingWentWrong,  // Default error message if null
            textAlign: TextAlign.center,
            style: AppTypography.t16Normal.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}


/// if empty
class EmptyList extends StatelessWidget {
  final String title ;
  final IconData?  icon ;
  const EmptyList({super.key , required this.title , this.icon});

  @override
  Widget build(BuildContext context) {
    return  Column(
mainAxisAlignment: MainAxisAlignment.center,
      children: [

        icon ==null ? SizedBox(
            height: screenHeight(context)*.3,
            child: SvgPicture.asset(AppAssets.empty)) : Opacity(
          opacity: 0.5,
            child: Icon(icon , size: 150.sp , color: const Color(0xffffa994),)) ,
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
