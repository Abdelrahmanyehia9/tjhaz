import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/helpers/icon_helper.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/core/widgets/error_widget.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/categories/view/widget/grid_category_shimmer.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  String parentName = " "  ;

  @override

  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // App Bar
            verticalSpace(16),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 101.w,
                    decoration:
                        BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: Offset(0, 4))
                    ]),
                    child: ListView.builder(
                      itemCount: AppConstants.categories.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async{
                          parentName = AppConstants.categories[index]["title"]! ;
                          context.loaderOverlay.show() ;
                          await context.read<CategoriesCubit>().getCategoriesByParentId(AppConstants.categories[index]["id"]!) ;
                          if(context.mounted){
                            context.loaderOverlay.hide();
                          }
                          setState(() {
                            context.read<CategoriesCubit>().currentIndex = index ;
                          });
                        },
                        child: sidebarItem(
                          img: AppConstants.categories[index]["image"]!,
                          title: AppConstants.categories[index]["title"]!,
                          isActive: context.read<CategoriesCubit>().currentIndex == index ,
                        ),
                      ),
                    ),
                  ),
                  // Main Content
                  BlocBuilder<CategoriesCubit , CategoriesStates>(
                    builder: (context , state){
                      if(state is CategoriesStateSuccess){
                        return Expanded(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal: 8.0.w , vertical: 8.h),
                            child: GridView.builder(

                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 107.w/85.h,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                return InkWell(onTap: (){
                                  context.push(AppRouter.entertainmentScreen , extra:{
                                    "id": state.categories[index].id,
                                    "categories": state.categories,
                                    "name": parentName
                                  }) ;
                                },
                                    child: categoryBox(category: state.categories[index].title??""));
                              },
                            ),
                          ),
                        ) ;
                      }else if(state is CategoriesStateFailure){
                        return AppErrorWidget(error: state.errorMsg,) ;
                      }
                      else {
                        return GridCategoryShimmer() ;
                      }


                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ) ;

  }

  Widget sidebarItem(
          {required String img, required String title, bool? isActive}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 101.w,
          height: 108.h,
          decoration: BoxDecoration(
              color: isActive == true ? Colors.grey.shade100 : AppColors.cWhite,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                  left: isActive == true
                      ? BorderSide(color: AppColors.secondaryColor, width: 4)
                      : BorderSide.none)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                SvgPicture.asset(img, height: 50), // Category Icon
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
  Widget categoryBox({required String category})=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        width: 107.w,height: 64.h,
        decoration: BoxDecoration(
          color: Color(0xffEAEAEA),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(IconHelper.getCategoriesIcon(category) , size: 38.sp, color: AppColors.secondaryColor,),
      ),
      Spacer(),
      Text(category.tr().toUpperCase(), style: AppTypography.t14light.copyWith(color: AppColors.primaryColor),maxLines: 1 , overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
      Spacer()
    ],
  );
}

