import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  int selectedIndex = 0; // 0 for English, 1 for Arabic

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ToggleButtons(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,

          splashColor: Colors.transparent ,

          borderRadius: BorderRadius.circular(8),
          isSelected: [selectedIndex == 0, selectedIndex == 1],
          onPressed: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          fillColor: AppColors.secondaryColor,
          selectedColor: Colors.white,
          color: AppColors.primaryColor,

          constraints: BoxConstraints(minWidth: 176.w, minHeight: 48.h),
          children: [
            Text(
              'ENGLISH',
              style: AppTypography.t12Normal,
            ),
            Text(
                'عربي',
                style: AppTypography.t12Normal
            ),
          ],
        ),
      ),
    ) ;

  }
}