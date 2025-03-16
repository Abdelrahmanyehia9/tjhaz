import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:toastification/toastification.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';
import '../utils/app_assets.dart';

void appToast(
    {BuildContext? context,
      required ToastificationType type,
      required String tittle,
          ToastificationStyle?   style ,
      required String description}) => toastification.show(
  margin:  EdgeInsets.symmetric(vertical: 36.h , horizontal: 16.w),
    alignment: Alignment.bottomCenter,
    showProgressBar: true,
    autoCloseDuration: Duration(seconds: 3),
    type: type,
    style: style ?? ToastificationStyle.fillColored,
    title: Text(tittle),
    description: Text(description),
    context: context);


void appDialog({required BuildContext context  ,Color? backgroundColor ,required String title   ,required String  contentMsg , void Function()? onConfirmed ,    })=>showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: AppColors.cWhite,

      title: Text(title , style: AppTypography.t14Bold.copyWith(color: AppColors.secondaryColor),),
      content: Text(contentMsg ,style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),),
      actions: [
        TextButton(

            onPressed: () {
              context.pop();
            },
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,

            ),
            child: Text(AppStrings.cancel , style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),)),
        ElevatedButton(

            onPressed: onConfirmed ,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
            ),
            child: Text(AppStrings.confirm , style: AppTypography.t12Normal)),
      ],
    ));
void appBottomSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (_) => Container(
      color: Colors.white,

      height: MediaQuery.of(context).size.height-240.h,
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                   image: DecorationImage(image: AssetImage(AppAssets.seaTrip) , fit: BoxFit.cover , colorFilter: ColorFilter.mode(Colors.black54, BlendMode.xor))
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
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: Icon(Icons.arrow_back , color: Colors.white,),
                  ),
                ),
              )
            ],
          ) ,
          Spacer() ,
          Padding(
            padding:  EdgeInsets.all(0.0.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome Guest" , style: AppTypography.t24Light.copyWith(color: AppColors.primaryColor),) ,
                verticalSpace(8) ,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.0.w),
                  child: Text("Sign in or sign up to enjoy a personalized experience tailored just for you." , textAlign: TextAlign.center , softWrap: true   ,style: AppTypography.t14light.copyWith(color: AppColors.cMediumGrey),),
                ) ,
                verticalSpace(24),
                AuthButton(tittle: AppStrings.login, onPressed: (){}) ,
                AuthButton(tittle: AppStrings.continueAsGuest, onPressed: (){
                  context.pop() ;
                } , bgColor: AppColors.secondaryColor,) ,
                verticalSpace(4) ,
          //       Text(AppStrings.continueAsGuest , style: AppTypography.t16Bold.copyWith(color: AppColors.secondaryColor  , decoration: TextDecoration.underline , decorationColor: AppColors.secondaryColor , decorationThickness: 2,),)
          // ,verticalSpace(16)



              ],
            ),
          ) ,
          Spacer()

        ],
      ),
    ),
  );
}



