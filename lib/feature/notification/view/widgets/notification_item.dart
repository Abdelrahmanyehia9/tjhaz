import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';

import '../../../../core/helpers/spacing.dart';
class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w , vertical: 8.h),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: 80.h , 
              minWidth: screenWidth(context)
            ),
            decoration: BoxDecoration(

              color: Colors.white ,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200 ,
                    blurRadius: 4,
                    offset: const Offset(0, 3)
                )
              ] ,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    width: 80.w ,height: 80.h,
                      child: CachedNetworkImageWidget(imgUrl: "https://stanzfishing.com/cdn/shop/files/4DF2F33E-0DE2-4F4E-BA68-AF70258415D1.jpg?v=1706582590&width=1946" )),
                ) ,
                horizontalSpace(16.w) ,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ORDER SHIPPED".toUpperCase() , style: AppTypography.t14Normal.copyWith(color: AppColors.secondaryColor),) ,
                      verticalSpace(2),
                      Text("Connect with them on Dribbble; the global community for designers " , style: AppTypography.t10Normal.copyWith(color: Colors.grey),)


                    ],
                  ),
                )

              ],
            ),

          ),
          Padding(
            padding:  EdgeInsets.all(8.0.w),
            child: const Icon(Icons.close , color: Colors.grey,),
          )
        ],
      ),
    );
  }
}
