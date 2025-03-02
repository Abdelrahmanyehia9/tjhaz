import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/widgets/shimmer_container.dart';

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
    child: ShimmerContainer(width: screenWidth(context)*.3, height: screenHeight(context )*.175 , radius: 8,),
  );
  Widget showMoreDistButton(context)=>
      ShimmerContainer(width: double.infinity, height: 60.h , radius: 8,) ;
}
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
        ShimmerContainer(width: screenWidth(context)*.425, height: screenHeight(context)*.11 , radius: 8,),
        verticalSpace(8),
        ShimmerContainer(width: screenWidth(context)*.425, height: 20.h , radius: 4,),
        Spacer(),
      ],
    ),
  );

}
