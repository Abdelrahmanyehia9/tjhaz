import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  final double? width ;
  final double? height  ;
  const LottieAnimation({super.key ,this.height  , this.width});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
          width: width ?? 130.w, height: height ??  130.h,
          child: Lottie.asset("assets/images/appLoading.json")),
    );
  }
}
