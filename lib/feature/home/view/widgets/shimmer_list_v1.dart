import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/widgets/loading_shimmer.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/screen_size.dart';

class ShimmerListV1 extends StatelessWidget {
  const ShimmerListV1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: screenHeight(context) * 0.175,
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => cardV1(
              context,
            ),
          ),
        ),
        verticalSpace(8),
        // state.trips.length>4?showMoreDistButton(context):SizedBox(),
        showMoreDistButton(context)
      ],
    ) ;;
  }

  Widget cardV1(context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 4.w),
    child: LoadingShimmerContainer(width: screenWidth(context)*.3, height: screenHeight(context )*.175 , radius: 8,),
  );
  Widget showMoreDistButton(context)=>
      LoadingShimmerContainer(width: double.infinity, height: 60.h , radius: 8,) ;
}
