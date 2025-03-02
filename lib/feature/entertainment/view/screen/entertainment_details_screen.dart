import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/core/widgets/app_slider.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_facilities.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/widgets/icon_and_text.dart';

class EntertainmentDetailsScreen extends StatelessWidget {
  final EntertainmentDetailsModel model;

  const EntertainmentDetailsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FixedBottomButton(onPressed: () {
        context.push(AppRouter.reservationScreen , extra: model) ;
      }),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(),
                AppSlider(
                  height: screenHeight(context) * .3,
                    imageList: model.images  , addToFavourite: true,   ),
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
              headlineAndText(model.description, AppStrings.description),
                model.details == null
                    ? SizedBox()
                    : headlineAndText(model.details!, AppStrings.details),
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
      items.add(IconAndTextHorizontal(
        title: "${model.guests} ${AppStrings.guests}",
        icon: Icons.person,
      ));
    }

    items.add(IconAndTextHorizontal(
      title: model.location ?? "Unknown Location",
      icon: Icons.location_on,
    ));


      items.add(IconAndTextHorizontal(
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

