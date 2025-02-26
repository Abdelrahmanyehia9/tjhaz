import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_localization.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: screenHeight(context)*.3,
                child: SvgPicture.asset(isDisconnected == true  ? AppConstants.disconnected : AppConstants.error )) ,
                 verticalSpace(16) ,
                 Text(error == null ? AppLocalizationsString.somethingWentWrong:"$error ",overflow: TextOverflow.ellipsis,
                      style: AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),)
          ],
        ),
      ),
    );
  }
}
