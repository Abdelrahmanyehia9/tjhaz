import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';
import 'package:tjhaz/feature/notification/view/widgets/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
          child:  Column(
            children: [

              const AppLogoImage(),
               AppHeadline(tittle: AppStrings.notifications , topPadding: 0, ),
              Expanded(
                child: ListView(
                  children: const [
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                    NotificationItem() ,
                  ],
                
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
