import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/refresh_idecator.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_grid.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_states.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/errors_widgets.dart';
import '../../../../core/widgets/toggle_pages.dart';
import '../../../entertainment/data/model/entertainment_details_model.dart';
import '../../../entertainment/view/widget/entertainment_loading.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<EntertainmentDetailsModel> fav = [];
  int index =  0 ;

  @override
  void initState() {
    super.initState();
    // You can leave this empty or initialize based on other logic if required
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<GetAllFavoriteCubit, GetAllFavoriteStates>(
          builder: (context, state) {
            // Update the `fav` list whenever the state changes
            if (state is GetAllFavoriteStatesSuccess) {
              fav = getFavByType(index+1, context.read<GetAllFavoriteCubit>().allFavorites); // Update `fav` when state changes
            }

            return RefreshableWidget(
              onRefresh: () async {
                await context.read<GetAllFavoriteCubit>().get();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AppHeadline(tittle: "Favourite"),
                      verticalSpace(4),
                      TogglePages(
                        width: 100.w,
                        onTap: (index) {
                          this.index = index;
                          setState(() {
                            fav = getFavByType(index + 1, context.read<GetAllFavoriteCubit>().allFavorites);
                          });
                        },
                        unSelectedTextStyle: AppTypography.t12Normal.copyWith(color: AppColors.cWhite),
                        selectedTextStyle: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
                        pages: List.generate(
                          4,
                              (_) => BlocBuilder<GetAllFavoriteCubit, GetAllFavoriteStates>(
                            builder: (context, state) {
                              if (state is GetAllFavoriteStatesSuccess) {
                                return fav.isNotEmpty
                                    ? EntertainmentGrid(items: fav)
                                    : EmptyList(title: "Favorites");
                              } else if (state is GetAllFavoriteStatesFailure) {
                                return AppErrorWidget(error: state.error);
                              } else {
                                return GridLoading();
                              }
                            },
                          ),
                        ),
                        title: [
                          AppStrings.trips,
                          AppStrings.wild,
                          AppStrings.activities,
                          "Products",
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<EntertainmentDetailsModel> getFavByType(int type, List<EntertainmentDetailsModel> allFav) {
    return allFav.where((element) => element.entertainmentType == type.toString()).toList();
  }
}
