import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/service/url_launcher.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/app_headline.dart';
import '../../../../core/widgets/global_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          children: [

            verticalSpace(36) ,
            const AppLogoImage() ,
            verticalSpace(16),
            AppHeadline(tittle: AppStrings.contactUs , topPadding: 0,),
            verticalSpace(16),
            contactUsItem(title: "Phone number" ,icon:  Icons.phone ,value:  "0123456789" , onTap: ()async{
              await UrlLauncherService.instance.launchPhoneCall("+201501634466") ;
            }) ,
            contactUsItem(title : AppStrings.email ,icon:  Icons.email ,value:  "2z8d8@example.com" , onTap:()async{
              await UrlLauncherService.instance.launchEmail("2z8d8@example.com") ;
            }) ,
            contactUsItem(title: "location" ,icon:  Icons.location_on ,value:  "www.tjhaz.com" , onTap: ()async{
              await UrlLauncherService.instance.launchLocation(latitude: 30.0444, longitude: 31.2357 , label: "Tjhaz") ;
            }) ,


          ],
        ),
      ),
    );
  }

  Widget contactUsItem({required String title ,required IconData icon ,required String value , GestureTapCallback ? onTap}) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4.0.h),
      child: CustomGestureDetector(
        onTap: onTap ,
        child: Container(
          padding: EdgeInsets.all(12.w),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.secondaryColor , ) ,
            borderRadius: BorderRadius.circular(8) ,

          ),
        child: Row(children: [
          Icon(icon , size: 24.sp, color: AppColors.secondaryColor,) ,
          horizontalSpace(8) ,
          Text("${title.toUpperCase()} / " , style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),),
          Text("${value.toUpperCase()} " , style: AppTypography.t12Normal.copyWith(color: AppColors.secondaryColor),)
        ],),
        ),
      ),
    ) ;
  }
}
