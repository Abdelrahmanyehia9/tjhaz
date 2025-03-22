import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/service/url_launcher.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_assets.dart';

class ContactUsSocialIcons extends StatelessWidget {
  const ContactUsSocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomGestureDetector(
          onTap: (){
            UrlLauncherService.instance.launchSocialMedia(SocialMediaPlatform.facebook, "tjhaz") ;
          },
          child: SizedBox(
              height: 40.h,width: 40.w,
              child: SvgPicture.asset(AppAssets.facebookAppLogo)),
        ) ,
        horizontalSpace(6) ,
        CustomGestureDetector(
          onTap: (){
            UrlLauncherService.instance.launchWhatsApp("+201501634466",message:  "help me pls") ;
          },
          child: SizedBox(
              height: 40.h,width: 40.w,
              child: SvgPicture.asset(AppAssets.whatsAppLogo)),
        ) ,
        horizontalSpace(6) ,

        CustomGestureDetector(
          onTap: (){
            UrlLauncherService.instance.launchSocialMedia(SocialMediaPlatform.instagram, "tjhaz") ;
          },
          child: SizedBox(
              height: 40.h,width: 40.w,
              child: SvgPicture.asset(AppAssets.instagramAppLogo)),
        ) ,
      ],
    );
  }
}
