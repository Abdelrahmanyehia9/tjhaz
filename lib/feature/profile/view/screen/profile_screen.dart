import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/feature/profile/view/widgets/profile_button.dart';
import '../widgets/language_toggle.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(16) ,
              AppHeadline(tittle: AppStrings.profile , hasBackButton: false,),
              verticalSpace(8) ,
              ProfileButton(text: "personal info" ,icon:  Icons.person),
              ProfileButton(text: "reset password" ,icon:  Icons.lock),
              ProfileButton(text: "My Favorites" ,icon:  Icons.favorite),
              ProfileButton(text: "contact us" ,icon:  Icons.support_agent),
              ProfileButton(text: "my orders"  ,icon:  Icons.receipt),
              ProfileButton(text: "my bookings"  ,icon:  Icons.calendar_today),
              ProfileButton(text: "about us"  ,icon:  Icons.contact_support),

              verticalSpace(16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("تغيير اللغة" , style: AppTypography.t11Bold.copyWith(color: AppColors.primaryColor),),
              ) ,
              LanguageToggle() ,
              verticalSpace(24) ,
              profileFooter()


            ],
          ),
        ),
      ),
    );
  }
Widget profileFooter() {
    return  Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Privacy And Policies\t |\t Terms and Conditions" , style: AppTypography.t12Normal.copyWith(color: AppColors.cDarkGrey),) ,
          verticalSpace(2) ,
          Text("version 1.0.0" , style: AppTypography.t11Light.copyWith(color: AppColors.secondaryColor),)
        ],
      ),
    ) ;

}
}
