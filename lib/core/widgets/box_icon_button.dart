import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/app_message.dart';

class FavouriteIcon extends StatelessWidget {
  final double? size;
  final GestureTapCallback? onTap;
  final bool isFavorite ;
  final bool isLoading ;
  const FavouriteIcon({super.key  ,this.size , this.onTap , this.isFavorite = false , this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return  CustomGestureDetector(
      onTap:  SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous) ?? true ? (){
        anonymousBottomSheet(context: context) ;
      }:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8)
        ),
        child: isLoading?SizedBox(
          width: 14.h,
          height: 14.h,

            child: const CircularProgressIndicator(color: Colors.white,
            strokeWidth: 1,)):Icon( isFavorite ?Icons.remove:AppIcons.favorite , color: Colors.white,size: size ?? 20,),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  final double? size;
  const NotificationIcon({super.key  ,this.size});

  @override
  Widget build(BuildContext context) {
    return  CustomGestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8)
        ),
        child: Icon(AppIcons.notification , color: Colors.white,size: size ?? 20,),
      ),
    );
  }
}
