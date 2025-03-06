import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/feature/profile/view/widgets/profile_button.dart';

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
              AppHeadline(tittle: AppStrings.profile),
              verticalSpace(16) ,
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


            ],
          ),
        ),
      ),
    );
  }

  Widget profileButton(String text , IconData icon) => Padding(
    padding:  EdgeInsets.symmetric(vertical: 6.0.h),
    child: InkWell(

      child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.cWhite,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 0.5,
                    blurRadius: 0.4,
                    offset: Offset(0, 2))
              ],
              border: Border.all(color: AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(children: [
                    Icon(icon , size: 24.sp, color: AppColors.secondaryColor,),
                    horizontalSpace(4) ,
                    Text(
                      text.toUpperCase(),
                      style: AppTypography.t12Normal.copyWith(
                          color: AppColors.primaryColor),
                    ),

                  ],) ,
                  Icon(Icons.arrow_forward_ios , size: 18.sp, color: AppColors.secondaryColor,)
                ],
              ),
            ),
          ),
    ),
  );
}
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