import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tjhaz/core/styles/typography.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/app_localization.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,
      child: TextFormField(
        cursorWidth: 1,

        style: AppTypography.t14Bold.copyWith(height: 0 , color: AppColors.primaryColor),
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          hintText: AppLocalizations.search,
          hintStyle: AppTypography.t14light.copyWith(color: AppColors.lightPrimaryColor),
          prefixIcon: Icon(Icons.search , color: AppColors.lightPrimaryColor, size: 18,), // User icon
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
