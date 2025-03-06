import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import '../styles/colors.dart';
import '../styles/typography.dart';

appToast(
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


appDialog({required BuildContext context  ,Color? backgroundColor ,required String title   ,required String  contentMsg , void Function()? onConfirmed ,    })=>showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: AppColors.cWhite,

      title: Text(title ,textAlign: TextAlign.center, style: AppTypography.t14Bold.copyWith(color: AppColors.secondaryColor),),
      content: Text(contentMsg , textAlign: TextAlign.center , style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),),
      actions: [
        TextButton(

            onPressed: () {
              context.pop();
            },
            style: TextButton.styleFrom(
              overlayColor: Colors.transparent,

            ),
            child: Text("Back" , style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),)),
        ElevatedButton(

            onPressed: onConfirmed ,
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white ,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
            ),
            child: Text("Confirm" , style: AppTypography.t12Normal)),
      ],
    ));