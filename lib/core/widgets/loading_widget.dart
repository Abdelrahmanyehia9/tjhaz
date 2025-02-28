import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingWidgetAnimation extends StatelessWidget {
  const LoadingWidgetAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
          width: 130.w, height: 130.h,
          child: Lottie.asset("assets/images/appLoading.json")),
    );
  }
}
