import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/screen_size.dart';

class CardV1 extends StatelessWidget {
final GestureTapCallback? onTap ;
final String img ;
const CardV1({super.key , this.onTap , required this.img});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 4.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: screenWidth(context) * .3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImageWidget(imgUrl: img)
          ),
        ),
      ),
    );
  }
}
class CardV2 extends StatelessWidget {
  final GestureTapCallback ? onTap ;
  final String imgUrl ;
  final String title ;
  const CardV2({super.key , this.onTap ,required this.title ,required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: screenWidth(context) * .425,
              height: screenHeight(context) * .11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(imgUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.w),
            child: Text(
              title,
              style: AppTypography.t14Normal.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );;
  }
}

