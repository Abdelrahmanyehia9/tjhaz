import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/app_slider.dart';
import 'package:tjhaz/core/widgets/refresh_idecator.dart';
import 'package:tjhaz/feature/home/logic/banners_cubit.dart';
import 'package:tjhaz/feature/home/logic/banners_states.dart';
import 'package:tjhaz/feature/home/logic/home_activities_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_activities_states.dart';
import 'package:tjhaz/feature/home/logic/home_store_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_store_state.dart';
import 'package:tjhaz/feature/home/logic/home_trips_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_trips_states.dart';
import 'package:tjhaz/feature/home/view/widgets/home_activities_sucess.dart';
import 'package:tjhaz/feature/home/view/widgets/home_store_success.dart';
import '../../../../core/widgets/errors_widgets.dart';
import '../../../../core/widgets/global_app_bar.dart';
import '../widgets/banner_slider.dart';
import '../widgets/home_category_item.dart';
import '../widgets/home_shimmer.dart';
import '../widgets/popular_destination_success.dart';


class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshableWidget(
      onRefresh: (){
        Future.wait([
        context.read<HomeActivitiesCubit>().getHomeActivities() ,
        context.read<HomeTripsCubit>().getHomeTrips() ,
        context.read<BannerCubit>().getBanners() ,
        context.read<HomeStoresCubit>().getHomeStores()

        ]);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GlobalAppBar(),
              //categories
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 16.0.h),
                child: homeCategories(context),
              ),
              //banners
              BlocBuilder<BannerCubit, BannersStates>(
                builder: (context, state) {
                  if (state is BannersStatesSuccess) {
                    List<String> imgList = state.banners.map((item)=>item.image).toList();
                    return state.banners.isNotEmpty? BannerSlider(imageList: imgList,)
                        : const SizedBox();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              verticalSpace(8),

              ///trips
              BlocBuilder<HomeTripsCubit, HomeTripsStates>(
                  builder: (context, state) {
                if (state is HomeTripsStatesSuccess) {
                  return PopularDestinationSuccess(
                    items: state.trips,
                  );
                } else if (state is HomeTripsStatesFailure) {
                  return AppErrorWidget(
                    error: state.errorMsg,
                  );
                } else {
                  return const ShimmerListV1();
                }
              }),

              ///activities
              BlocBuilder<HomeActivitiesCubit, HomeActivitiesStates>(
                  builder: (context, state) {
                if (state is HomeActivitiesStatesSuccess) {
                  return HomeActivitiesSuccess(items: state.activities);
                } else if (state is HomeActivitiesStatesFailure) {
                  return AppErrorWidget(
                    error: state.errorMsg,
                  );
                } else {
                  return const ShimmerListV2();
                }
              }),

              ///stores
              BlocBuilder<HomeStoresCubit, HomeStoreStates>(
                  builder: (context, state) {
                if (state is HomeStoreStatesSuccess) {
                  return HomeStoreSuccess(items: state.stores);
                } else if (state is HomeStoreStatesFailure) {
                  return AppErrorWidget(
                    error: state.error,
                  );
                } else {
                  return const ShimmerListV2();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeCategories(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          AppConstants.categories.length,
          (index) {
            final item = AppConstants.categories[index];
            return CustomGestureDetector(
              onTap: ()
  {
                index == 3 ?context.push(AppRouter.shopScreen) : context.push(AppRouter.entertainmentScreen,
                    extra: {"parent": item});
              },
              child: HomeCategoryItem(
                imgUrl: item["image"]!,
                title: item["title"]!,
              ),
            );
          },
        ),
      );
}
