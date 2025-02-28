import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/icon_helper.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_facilities.dart';
import 'package:tjhaz/feature/entertainment/view/widget/slider.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/amenities.dart';
import '../../../../core/widgets/icon_and_text.dart';

class EntertainmentDetailsScreen extends StatelessWidget {
  final EntertainmentDetailsModel model;

  const EntertainmentDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FixedBottomButton(onPressed: () {}),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                EntertainmentSlider(
                    imageList: model.images!),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    model.name,
                    style: AppTypography.t20Bold
                        .copyWith(color: AppColors.primaryColor),
                  ),
                ),
                entertainmentOption() ,
                verticalSpace(24),
                model.facilities == null ? SizedBox() : EntertainmentFacilities(
                  facilitiesComfortable: model.comfortFacilities!,
                  entertainmentFacilities: model.facilities!,),
              headlineAndText(model.description, AppLocalizationsString.description),
                model.details == null
                    ? SizedBox()
                    : headlineAndText(model.details!, AppLocalizationsString.details),
                verticalSpace(16)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headlineAndText(String details , String headLine) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.0.h, bottom: 8.h),
            child: Text(
              headLine.toUpperCase() ,
              style:
              AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Text(
            details,
            style: AppTypography.t10Normal
                .copyWith(color: AppColors.lightPrimaryColor.withOpacity(0.7)),
          ),
        ],
      );
  Widget entertainmentOption() {
    List<Widget> items = [];

    if (model.guests != null) {
      items.add(IconAndText(
        title: "${model.guests} ${AppLocalizationsString.guests}",
        icon: Icons.person,
      ));
    }

    items.add(IconAndText(
      title: model.location ?? "Unknown Location",
      icon: Icons.location_on,
    ));


      items.add(IconAndText(
        title: model.rates.toString(),
        icon: Icons.star,
      ));


    return Row(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          if (i > 0) horizontalSpace(20),
          items[i],
        ],
      ],
    );
  }

}

