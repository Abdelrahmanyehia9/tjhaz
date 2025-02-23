import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/constants.dart';
import 'package:tjhaz/feature/entertainment/logic/activity_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/activity_state.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_localization.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/fixed_bottom_button.dart';
import '../../../../core/widgets/icon_and_text.dart';
import '../widget/slider.dart';

class ActivityScreen extends StatefulWidget {
  final String activityID ;
  const ActivityScreen({super.key , required this.activityID});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    context.read<ActivityCubit>().getActivityByID(widget.activityID) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActivityCubit , ActivityStates>(
      builder: (context , states) {
        if (states is ActivityStatesSuccess) {
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
                      EntertainmentSlider(imageList: states.activity.images),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                        child: Text(states.activity.name[AppConstants
                            .currentLanguage]!, style: AppTypography.t20Bold
                            .copyWith(color: AppColors.primaryColor),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(title: "${states.activity
                              .guests!} ${AppLocalizations.guests}",
                              icon: Icons.person),
                          IconAndText(title: states.activity
                              .location?[AppConstants.currentLanguage] ??
                              "No specific location", icon: Icons.location_on),
                          IconAndText(title: states.activity.rates,
                              icon: Icons.star),
                          horizontalSpace(80)
                        ],),
                      verticalSpace(24),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0.h, bottom: 8.h),
                        child: Text(AppLocalizations.description.toUpperCase(),
                          style: AppTypography.t16Bold.copyWith(
                              color: AppColors.primaryColor),),
                      ),
                      Text(states.activity.description[AppConstants
                          .currentLanguage]!,
                        style: AppTypography.t10Normal.copyWith(color: AppColors
                            .lightPrimaryColor.withOpacity(0.7)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0.h, bottom: 8.h),
                        child: Text(AppLocalizations.details.toUpperCase(),
                          style: AppTypography.t16Bold.copyWith(
                              color: AppColors.primaryColor),),
                      ),
                      Text(
                        states.activity.details![AppConstants.currentLanguage]!,
                        style: AppTypography.t10Normal.copyWith(color: AppColors
                            .lightPrimaryColor.withOpacity(0.7)),
                      ),
                      verticalSpace(16)
                    ],
                  ),
                ),
              ),
            ),);
        } else if (states is ActivityStatesFailure) {
          return Center(child: Text(states.errorMessage));
        } else {
          return const AppLoading() ;
        }
      }

    );
  }
}
