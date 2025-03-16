import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/styles/colors.dart';

class FavouriteIcon extends StatelessWidget {
  final double? size;
  final GestureTapCallback? onTap;
  final bool isFavorite ;
  final bool isLoading ;
  const FavouriteIcon({super.key  ,this.size , this.onTap , this.isFavorite = false , this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:  onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(8)
        ),
        child: isLoading?SizedBox(
          width: 14.h,
          height: 14.h,

            child: CircularProgressIndicator(color: Colors.white,
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
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w , vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
      borderRadius: BorderRadius.circular(8)
      ),
      child: Icon(AppIcons.notification , color: Colors.white,size: size ?? 20,),
    );
  }
}
