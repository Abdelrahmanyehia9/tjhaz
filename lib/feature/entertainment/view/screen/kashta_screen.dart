import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_localization.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/fixed_bottom_button.dart';
import '../../../../core/widgets/icon_and_text.dart';
import '../widget/slider.dart';

class KashtaScreen extends StatelessWidget {
  const KashtaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FixedBottomButton(onPressed: (){}) ,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                EntertainmentSlider(imageList:[]),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0 , bottom: 8),
                  child: Text("kashta" , style: AppTypography.t20Bold.copyWith(color: AppColors.primaryColor),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndText(title:"No specific location",icon:  Icons.location_on),
                    IconAndText(title: "3.7" , icon: Icons.star) ,
                    horizontalSpace(80)
                  ],),
                verticalSpace(24) ,
                Padding(
                  padding:  EdgeInsets.only(top: 16.0.h , bottom: 8.h),
                  child: Text(AppLocalizations.description.toUpperCase() , style: AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),),
                ),
                Text("description" ,
                  style: AppTypography.t10Normal.copyWith(color: AppColors.lightPrimaryColor.withOpacity(0.7)),
                ) ,
                Padding(
                  padding:  EdgeInsets.only(top: 16.0.h , bottom: 8.h),
                  child: Text("details".toUpperCase() , style: AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),),
                ),
                Text("details" ,
                  style: AppTypography.t10Normal.copyWith(color: AppColors.lightPrimaryColor.withOpacity(0.7)),
                ) ,
                verticalSpace(16)
              ],
            ),
          ),
        ),
      ),);
  }
}
