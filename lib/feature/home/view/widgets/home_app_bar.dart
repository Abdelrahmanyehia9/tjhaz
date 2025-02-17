import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/feature/home/view/widgets/search_text_field.dart';

import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/box_action_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
              BoxActionButton(
                icon: Icons.favorite,
              ),
              horizontalSpace(4),
              BoxActionButton(icon: Icons.notifications),
            ],
          )
        ],
      );
}
