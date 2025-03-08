import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/routes/app_router.dart';
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
        Center(
            child: SizedBox(
          width: 120.w,
          height: 90.h,
          child: Image.asset(
            AppAssets.splashLogo,
            fit: BoxFit.cover,
          ),
        )),
        homeSearch(context),
      ],
    );
  }

  Widget homeSearch(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: screenWidth(context) * .7, child: SearchTextField()),
          Row(
            children: [
              FavouriteIcon(onTap: (){
                context.push(AppRouter.favoriteScreen);
              },),
              horizontalSpace(4),
              NotificationIcon(),
            ],
          )
        ],
      );
}
