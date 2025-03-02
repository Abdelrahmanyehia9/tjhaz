import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';
import 'app_back_button.dart';

class AppHeadline extends StatelessWidget {
  final String tittle ;
  final TextStyle? textStyle ;
  const AppHeadline({super.key , required this.tittle , this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, bottom: 10.h),
      child: Row(
        children: [
          AppBackButton(),
          Spacer(),
          Text(
            tittle.toUpperCase(),
            style:textStyle?? AppTypography.t24Bold
                .copyWith(color: AppColors.secondaryColor),
          ),
          Spacer()
        ],
      ),
    );
  }
}
