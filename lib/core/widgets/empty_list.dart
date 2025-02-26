import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/utils/constants.dart';

import '../utils/screen_size.dart';

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
               text: AppLocalizationsString.sorry,
               children: [
                 TextSpan(
          text: "$title ",
                 ),
                 TextSpan(
          text: AppLocalizationsString.notAvailableStayTuned,
                 ),
               ]
             ),


         )

        
        
      ],
    );
  }
}
