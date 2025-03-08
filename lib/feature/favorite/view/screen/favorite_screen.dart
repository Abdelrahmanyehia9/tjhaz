import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/toggle_pages.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w
          ),
          child: Column(
            children: [
        
              AppHeadline(tittle: "Favourite") ,
              verticalSpace(4) ,
        
              TogglePages(
                width: 100.w,
                unSelectedTextStyle: AppTypography.t12Normal.copyWith(color: AppColors.cWhite),
                selectedTextStyle: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
                pages: List.generate(5, (index)=> Text(index.toString())),
                title: [
                  AppStrings.trips,
                  AppStrings.wild,
                  AppStrings.activities ,
                  "Products"
                ],
              )
        
        
        
        
        
        
            ],
        
        
        
          ),
        ),
      ),
    );
  }
}
