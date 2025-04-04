import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_states.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/app_message.dart';
import '../../data/models/home_model.dart';
import 'home_cards.dart';
import 'headline_view_more.dart';

class PopularDestinationSuccess extends StatelessWidget {
  final List<HomeModel> items;

  const PopularDestinationSuccess({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EntertainmentDetailsCubit, EntertainmentDetailsStates>(
      listener: (context, state) {
        if (state is EntertainmentDetailsStatesSuccess) {
          context.push(AppRouter.entertainmentDetailsScreen,
              extra: state.entertainmentModel);
        }
      },
      child: Column(
        children: [
          HeadlineViewMore(title: AppStrings.popularDestinations),
          SizedBox(
            height: screenHeight(context) * 0.175,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CardV1(
                img: items[index].imgUrl,
                onTap: () {
                  context.read<EntertainmentDetailsCubit>().findEntertainmentByID(items[index].id);
                },
              ),
            ),
          ),
          verticalSpace(8),
          showMoreDistButton(context),
        ],
      ),
    );
  }

  Widget showMoreDistButton(BuildContext context) => CustomGestureDetector(
    child: ElevatedButton(
      onPressed: () {
        context.push(AppRouter.entertainmentScreen,
            extra: {"parent": AppConstants.categories[0]});
      },
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        fixedSize: Size(screenWidth(context), 30.h),
        shadowColor: Colors.transparent,
        side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        AppStrings.showMore,
        style: AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),
      ),
    ),
  );
}
