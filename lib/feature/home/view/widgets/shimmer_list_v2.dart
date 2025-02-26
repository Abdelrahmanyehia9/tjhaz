import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tjhaz/core/widgets/loading_shimmer.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/screen_size.dart';

class ShimmerListV2 extends StatelessWidget {
  const ShimmerListV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight(context) * 0.175,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => cardV2(
              context,
            ),
          ),
        ),
        verticalSpace(8),
        // state.trips.length>4?showMoreDistButton(context):SizedBox(),
      ],
    ) ;;
  }
  Widget cardV2( context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoadingShimmerContainer(width: screenWidth(context)*.425, height: screenHeight(context)*.11 , radius: 8,),
        verticalSpace(8),
        LoadingShimmerContainer(width: screenWidth(context)*.425, height: 20.h , radius: 4,),
        Spacer(),
      ],
    ),
  );

}
