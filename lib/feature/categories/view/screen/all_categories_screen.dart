import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/icon_helper.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/categories/view/widget/categories_loading_shimmer.dart';
import '../../../../core/widgets/errors_widgets.dart';
import '../../data/model/cateory_model.dart';
import '../widget/side_bar_main_categories.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          // App Bar
          verticalSpace(16),
          Expanded(
            child: Row(
              children: [
                //sidebar
                SideBarMainCategories(),
                // Main Content
                   BlocBuilder<CategoriesCubit, CategoriesStates>(
                        builder: (context, state) {
                          if (state is CategoriesStateSuccess) {
                            List<CategoryModel> categories = state.categories;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.w, vertical: 8.h),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 107.w / 85.h,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                        context.read<CategoriesCubit>().activeMainCategoryIndex != 3 ?
                                        context.push(
                                              AppRouter.entertainmentScreen,
                                              extra: {
                                                "parent": AppConstants
                                                        .categories[
                                                    context
                                                        .read<CategoriesCubit>()
                                                        .activeMainCategoryIndex],
                                                "active": index
                                              }
                                              ) : context.push(AppRouter.shopScreen , extra: index);
                                        },
                                        child: categoryBox(
                                            category: categories[index]));
                                  },
                                ),
                              ),
                            );
                          } else if (state is CategoriesStateFailure) {
                            return AppErrorWidget(
                              error: state.errorMsg,
                            );
                          } else {
                            return CategoriesLoadingShimmer();
                          }
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryBox({required CategoryModel category}) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: 107.w,
              height: 64.h,
              decoration: BoxDecoration(
                  color: Color(0xffEAEAEA),
                  borderRadius: BorderRadius.circular(8),
                  image: category.image != null
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(category.image!),
                          fit: BoxFit.cover)
                      : null),
              child: category.image == null
                  ? Icon(
                      IconHelper.getCategoriesIcon(category.title),
                      size: 38.sp,
                      color: AppColors.secondaryColor,
                    )
                  : null),
          Spacer(),
          Text(
            category.title.tr().toUpperCase(),
            style:
                AppTypography.t14light.copyWith(color: AppColors.primaryColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Spacer()
        ],
      );
}
