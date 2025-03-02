import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/widgets/search_text_field.dart';

import '../utils/constants.dart';
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
            AppConstants.splashLogo,
            fit: BoxFit.cover,
          ),
        )),
        homeSearch(context),
      ],
    );
  }

  Widget homeSearch(context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: screenWidth(context) * .7, child: SearchTextField()),
          Row(
            children: [
              BoxIconButton(
                icon: AppIcons.favorite,
              ),
              horizontalSpace(4),
              BoxIconButton(icon: AppIcons.notification),
            ],
          )
        ],
      );
}
