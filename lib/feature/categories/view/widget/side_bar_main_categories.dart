import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../logic/categories_cubit.dart';

class SideBarMainCategories extends StatefulWidget {
  const SideBarMainCategories({super.key});

  @override
  State<SideBarMainCategories> createState() => _SideBarMainCategoriesState();
}

class _SideBarMainCategoriesState extends State<SideBarMainCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 101.w,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4))
      ]),
      child: ListView.builder(
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            setState(() {
              context.read<CategoriesCubit>().activeMainCategoryIndex = index;
            });

            await context.read<CategoriesCubit>().getCategoriesByParentId(AppConstants.categories[index]["id"]!);

          },
          child: sidebarItem(
            img: AppConstants.categories[index]["image"]!,
            title: AppConstants.categories[index]["title"]!,
            isActive: context.read<CategoriesCubit>().activeMainCategoryIndex ==
                index,
          ),
        ),
      ),
    );
  }

  Widget sidebarItem(
          {required String img, required String title, bool? isActive}) =>
      Padding(
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
}
