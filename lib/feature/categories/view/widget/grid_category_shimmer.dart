import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tjhaz/core/widgets/loading_shimmer.dart';

class GridCategoryShimmer extends StatelessWidget {
  const GridCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
          itemCount: 12,
          itemBuilder: (context, index) {
            return categoryBox();
          },
        ),
      ),
    );
  }
  Widget categoryBox()=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LoadingShimmerContainer(width: 107.w, height: 64.h , radius: 8 ,) ,
      Spacer(),
      LoadingShimmerContainer(width: 100.w, height: 16.h , radius: 4,) ,
      Spacer()
    ],
  );
}
