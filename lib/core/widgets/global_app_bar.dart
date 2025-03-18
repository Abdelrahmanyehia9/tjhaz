import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/search_text_field.dart';
import '../utils/app_assets.dart';
import '../helpers/spacing.dart';
import '../utils/screen_size.dart';
import 'box_icon_button.dart';

class GlobalAppBar extends StatelessWidget {
  const GlobalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(8),
        const CustomGestureDetector(child: AppLogoImage()) ,
        homeSearch(context),
      ],
    );
  }

  Widget homeSearch(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: screenWidth(context) * .7, child: const SearchTextField()),
          Row(
            children: [
              FavouriteIcon(onTap: (){
                context.push(AppRouter.favoriteScreen);
              },),
              horizontalSpace(4),
              const NotificationIcon(),
            ],
          )
        ],
      );
}
class AppLogoImage extends StatelessWidget {
  final double width ;
  final double  height ;
  const AppLogoImage({super.key , this.width = 120 , this.height = 90});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: width.w,
          height: height.h,
          child: Padding(
            padding:  EdgeInsets.all(16.0.w),
            child: Image.asset(
              AppAssets.splashLogo,
              fit: BoxFit.cover,
            ),
          ),
        ))   ;
  }
}
