import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 18.0.w , vertical: 16.h),
      child: CircularProgressIndicator(color: AppColors.secondaryColor,),
    ) ;
  }
}
