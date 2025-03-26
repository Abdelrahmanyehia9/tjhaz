import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_assets.dart';

void showAboutUs(BuildContext context) {
  Widget titleAndDescription({required String title , required String description})=>Padding(
    padding:  EdgeInsets.all(16.0.w),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),) ,
          verticalSpace(4)  ,
          Text(description , style: AppTypography.t10Normal.copyWith(color: AppColors.lightPrimaryColor),)
        ]
    ),
  ) ;

  showModalBottomSheet(
    isScrollControlled: true,

    context: context, builder: (_)=>   Container(
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r) , topRight: Radius.circular(16.r))

     ),

  height: MediaQuery.of(context).size.height-140.h,
  width: double.infinity,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 140.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  image: DecorationImage(image: AssetImage(AppAssets.seaTrip) ,alignment: Alignment.bottomLeft, fit: BoxFit.cover , colorFilter: ColorFilter.mode(AppColors.lightPrimaryColor, BlendMode.darken))
              ),
              child : Image.asset(AppAssets.appLogo , fit: BoxFit.cover,) ,
            ),
            Padding(
              padding:  EdgeInsets.all(16.0.w),
              child: InkWell(
                onTap: (){
                  context.pop() ;
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  child: const Icon(Icons.arrow_back , color: Colors.white,),
                ),
              ),
            )
          ],
        ) ,

        // SizedBox(
        //     width: 150.w,height: 80.h,
        //     child: Image.asset(AppAssets.splashLogo)) ,
        titleAndDescription(
            title: AppStrings.aboutTjhazTitle,
            description: AppStrings.aboutTjhazDescription
        ),

        titleAndDescription(
            title: AppStrings.visionTitle ,
          description: AppStrings.vision
        ),

        titleAndDescription(
            title: AppStrings.boatRentalTitle,
          description: AppStrings.boatRental
        ),

        titleAndDescription(
            title: AppStrings.chaletRentalTitle,
          description:  AppStrings.chaletRental
        ),

        titleAndDescription(
            title: AppStrings.campingAndWaterActivitiesTitle,
          description: AppStrings.campingAndWaterActivities
        ),

        titleAndDescription(
          title: AppStrings.yachtDiningServicesTitle,
          description: AppStrings.yachtDiningServices
        ),

        titleAndDescription(
            title: AppStrings.onlineShoppingTitle,
          description:  AppStrings.onlineShopping
        ),

        titleAndDescription(
          title: AppStrings.easyBookingTitle,
          description: AppStrings.easyBooking
        ),

        titleAndDescription(
          title: AppStrings.securePaymentTitle,
          description: AppStrings.securePayment
        ),

        titleAndDescription(
          title:  AppStrings.whyTjhazTitle,
          description: AppStrings.whyTjhaz
        ),

        titleAndDescription(
            title: AppStrings.unforgettableExperienceTitle,
            description:AppStrings.unforgettableExperience
        ),



      ],
    ),
  ),
)

   );
   
   
   
   
}