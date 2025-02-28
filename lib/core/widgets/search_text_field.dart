import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/typography.dart';

import '../styles/colors.dart';
import '../utils/app_localization.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40.h,
      child: TextFormField(
        cursorWidth: 1,

        style: AppTypography.t12Normal.copyWith(height: 2, color: AppColors.primaryColor),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,

          hintText: AppLocalizationsString.search,

          hintStyle: AppTypography.t12Normal.copyWith(color: AppColors.lightPrimaryColor ,),
          prefixIcon: Icon(Icons.search , color: AppColors.lightPrimaryColor, size: 24.sp,), // User icon
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                color: AppColors.lightPrimaryColor // Border color
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.lightPrimaryColor ,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.primaryColor ,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red ,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.red ,
              width: 1.0,
            ),
          ),

        ),
      ),
    );
  }
}
