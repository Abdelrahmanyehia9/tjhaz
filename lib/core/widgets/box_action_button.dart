import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';

class BoxIconButton extends StatelessWidget {
  final IconData icon ;
  final double? size;
  const BoxIconButton({super.key  , required this.icon  , this.size});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
borderRadius: BorderRadius.circular(8)
      ),
      child: Icon(icon , color: Colors.white,size: size ?? 20,),
    );
  }
}
