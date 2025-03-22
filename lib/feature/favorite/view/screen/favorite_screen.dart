import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/styles/app_icon.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/errors_widgets.dart';
import 'package:tjhaz/core/widgets/refresh_idecator.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_grid.dart';
import 'package:tjhaz/feature/entertainment/view/widget/entertainment_loading.dart';
import 'package:tjhaz/feature/favorite/logic/favorite_cubit.dart';
import 'package:tjhaz/feature/favorite/logic/favorite_states.dart';
import 'package:tjhaz/feature/shop/view/widget/product_grid.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/styles/card_sizes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/toggle_pages.dart';
import '../../../entertainment/data/model/entertainment_details_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<EntertainmentDetailsModel> fav = [];
  int index = 1;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshableWidget(
        onRefresh: () async {
          await context.read<FavoriteCubit>().getAllFavorites();
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppHeadline(tittle: AppStrings.favorites),
                  verticalSpace(4),
                  TogglePages(
                    width: 100.w,

                    onTap: (newIndex) {
                      setState(() {
                        index = newIndex + 1;
                      });
                    },
                    unSelectedTextStyle: AppTypography.t14Normal
                        .copyWith(color: AppColors.cWhite),
                    selectedTextStyle: AppTypography.t14Normal
                        .copyWith(color: AppColors.cWhite),
                    pages: List.generate(
                      4,
                          (_) => BlocConsumer<FavoriteCubit, FavoriteStates>(
                        buildWhen: (previous, current) =>
                        current is GetFavoriteStatesSuccess ||
                            current is AddOrRemoveToFavoriteFailure,
                        listener: (context, state) {
                          if (state is GetFavoriteStatesSuccess) {
                            fav = state.favorites;
                          } else if (state is AddOrRemoveToFavoriteSuccess ||
                              state is AddOrRemoveToFavoriteFailure) {
                            context.read<FavoriteCubit>().getAllFavorites();
                          }
                        },
                        builder: (context, state) {
                          if (state is GetFavoriteStatesSuccess) {
                            // Special handling for products (index 4)
                            if (index == 4) {
                              List<ProductModel> favProducts = context.read<FavoriteCubit>().favProducts;
                              if (favProducts.isNotEmpty) {
                                return favProductGrid(favProducts);
                              } else {
                                return SizedBox(
                                    height: 520.h,
                                    child: Center(
                                        child: EmptyList(
                                            title: AppStrings.favoriteProducts,
                                            icon: AppIcons.favorite)
                                    )
                                );
                              }
                            }
                            // Handle entertainment items (indexes 1,2,3)
                            else {
                              List<EntertainmentDetailsModel> filteredFav = getFavByType(index, fav);
                              return filteredFav.isNotEmpty
                                  ? EntertainmentGrid(items: filteredFav)
                                  : SizedBox(
                                  height: 520.h,
                                  child: Center(
                                      child: EmptyList(
                                          title: "${AppConstants.categories[index-1]["title"]} ${AppStrings.favorites}",
                                          icon: AppIcons.favorite
                                      )
                                  )
                              );
                            }
                          } else if (state is GetFavoriteStatesFailure) {
                            return SizedBox(
                                height: 450.h,
                                child: Center(
                                    child: AppErrorWidget(error: state.error)
                                )
                            );
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
                      AppStrings.products,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<EntertainmentDetailsModel> getFavByType(int type, List<EntertainmentDetailsModel> allFav) {
    return allFav
        .where((element) => element.entertainmentType == type.toString())
        .toList();
  }
  Widget favProductGrid(List<ProductModel> items) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: items.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: CardSizes.productCard.width / CardSizes.productCard.height,
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
    ),
    itemBuilder: (context, index) {
      final product = items[index];
      return InkWell(
        onTap: () => context.push(AppRouter.shopDetailsScreen, extra: product),
        child: ProductCard(productModel: product),
      );
    },
  );
}