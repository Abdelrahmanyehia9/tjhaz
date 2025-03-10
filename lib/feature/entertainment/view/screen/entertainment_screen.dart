import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/cards/square_card.dart';
import 'package:tjhaz/core/widgets/cards/trip_card.dart';
import 'package:tjhaz/core/widgets/refresh_idecator.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainments_states.dart';
import 'package:tjhaz/core/widgets/global_app_bar.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/errors_widgets.dart';
import '../../../categories/view/widget/categories_containers.dart';
import '../widget/entertainment_grid.dart';
import '../widget/entertainment_loading.dart';

class EntertainmentScreen extends StatefulWidget {
  final Map<String, String> parentCategory;
  final int? activeCategory;
  const EntertainmentScreen({super.key, required this.parentCategory, this.activeCategory});

  @override
  State<EntertainmentScreen> createState() => _EntertainmentScreenState();
}

class _EntertainmentScreenState extends State<EntertainmentScreen> {
  late ValueNotifier<int> activeIndex;
  late ValueNotifier<String> subCategoryTitle;
  late String parentTitle;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    parentTitle = widget.parentCategory['title']!;
    activeIndex = ValueNotifier(widget.activeCategory ?? 0);
    subCategoryTitle = ValueNotifier("");
    context.read<CategoriesCubit>().getCategoriesByParentId(widget.parentCategory["id"]!);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshableWidget(
          onRefresh: (){

            context.read<CategoriesCubit>().getCategoriesByParentId(widget.parentCategory["id"]!);          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalAppBar(),
                  AppHeadline(tittle: parentTitle),
                  BlocConsumer<CategoriesCubit, CategoriesStates>(
                    builder: (context, state) {
                      if (state is CategoriesStateSuccess) {
                        List<CategoryModel> categories = state.categories;
                        categories.insert(0, categories.removeAt(activeIndex.value));
                        activeIndex.value = 0;
                        return categories.isNotEmpty
                            ? SizedBox(
                          height: 110.h,
                          child: ValueListenableBuilder<int>(
                            valueListenable: activeIndex,
                            builder: (_, selectedIndex, __) {
                              return ListView.separated(
                                scrollDirection: Axis.horizontal,
                                controller: scrollController,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    activeIndex.value = index;
                                    subCategoryTitle.value = categories[index].title;
                                    searchItemsByID(context, categories[index].id);
                                  },
                                  child: categories.first.image == null
                                      ? CircularCategory(
                                    isActive: selectedIndex == index,
                                    name: categories[index].title,
                                  )
                                      : RectangularCategory(
                                    isActive: selectedIndex == index,
                                    name: categories[index].title.tr(),
                                    img: categories[index].image!,
                                  ),
                                ),
                                separatorBuilder: (context, state) => horizontalSpace(16),
                                itemCount: categories.length,
                              );
                            },
                          ),
                        )
                            : Container();
                      } else if (state is CategoriesStateLoading) {
                        return EntertainmentCategoriesLoading();
                      } else {
                        return SizedBox();
                      }
                    },
                    listener: (context, state) {
                      if (state is CategoriesStateSuccess) {
                        Future.microtask(() {
                          if (context.mounted) {
                            subCategoryTitle.value = state.categories[activeIndex.value].title;
                            context
                                .read<EntertainmentCubit>()
                                .getEntertainmentsByCatID(state.categories[activeIndex.value].id);
                          }
                        });
                      }
                    },
                  ),
                  verticalSpace(16),
                  BlocBuilder<EntertainmentCubit, EntertainmentsStates>(
                    builder: (context, state) {
                      if (state is EntertainmentItemsSuccess) {
                        return state.items.isNotEmpty
                            ? EntertainmentGrid(items: state.items,)
                            : ValueListenableBuilder<String>(
                          valueListenable: subCategoryTitle,
                          builder: (_, title, __) => EmptyList(title: title.tr()),
                        );
                      } else if (state is EntertainmentItemsFailure) {
                        return AppErrorWidget(error: state.errorMsg);
                      } else {
                        return GridLoading();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchItemsByID(BuildContext context, String id) async {
    await context.read<EntertainmentCubit>().getEntertainmentsByCatID(id);
  }

  @override
  void dispose() {
    activeIndex.dispose();
    subCategoryTitle.dispose();
    super.dispose();
  }
}
