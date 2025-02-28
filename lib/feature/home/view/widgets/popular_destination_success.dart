import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_states.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/screen_size.dart';
import '../../data/models/home_model.dart';
import 'home_cards.dart';
import 'headline_view_more.dart';

class PopularDestinationSuccess extends StatelessWidget {
  final List<HomeModel> items;

  const PopularDestinationSuccess({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineViewMore(
          title: AppLocalizationsString.popularDestinations,
        ),
        SizedBox(
          height: screenHeight(context) * 0.175,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => BlocListener<
                EntertainmentDetailsCubit, EntertainmentDetailsStates>(
              listener: (context, state) {
                if (state is EntertainmentDetailsStatesSuccess) {
                  context.push(AppRouter.entertainmentDetailsScreen,
                      extra: state.entertainmentModel);
                }
              },
              child: CardV1(
                img: items[index].imgUrl,
                onTap: () async {
                  context.loaderOverlay.show();
                  await context
                      .read<EntertainmentDetailsCubit>()
                      .findEntertainmentByID(items[index].id);
                  if (context.mounted) {
                    context.loaderOverlay.hide();
                  }
                },
              ),
            ),
          ),
        ),
        verticalSpace(8),
        showMoreDistButton(context)
      ],
    );
  }

  Widget showMoreDistButton(BuildContext context) => ElevatedButton(
        onPressed: () {
          context.push(AppRouter.entertainmentScreen,
              extra: {"parent": AppConstants.categories[0]});
        },
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          fixedSize: Size(screenWidth(context), 30.h),
          shadowColor: Colors.transparent,
          side: BorderSide(color: AppColors.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          AppLocalizationsString.showMore,
          style:
              AppTypography.t12Normal.copyWith(color: AppColors.primaryColor),
        ),
      );
}
