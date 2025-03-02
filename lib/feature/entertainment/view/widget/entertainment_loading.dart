import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/widgets/shimmer_container.dart';

class EntertainmentGridLoading extends StatelessWidget {
  const EntertainmentGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      // Makes GridView take only needed space
      physics: const NeverScrollableScrollPhysics(),
      // Disable GridView's scrolling
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio:
            CardSizes.productCard.width / CardSizes.productCard.height,
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) => gridItem(),
    );
  }

  Widget gridItem() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerContainer(
            width: CardSizes.productCard.width,
            height: CardSizes.productCard.height - 48.h,
            radius: 8,
          ),
          verticalSpace(12),
          ShimmerContainer(
            width: CardSizes.productCard.width,
            height: 16.h,
            radius: 2,
          ),
          verticalSpace(6),
          ShimmerContainer(
            width: CardSizes.productCard.width - 50.w,
            height: 12.h,
            radius: 1,
          )
        ],
      );
}

class EntertainmentCategoriesLoading extends StatelessWidget {
  const EntertainmentCategoriesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        // Makes GridView take only needed space
        physics: const NeverScrollableScrollPhysics(),
        // Disable GridView's scrolling
        itemCount: 12,
        itemBuilder: (context, index) => catItem(),
      ),
    );
  }

  Widget catItem() => Padding(
    padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: CircleAvatar(radius: 36.sp, backgroundColor: Colors.grey,   )
            ),
            verticalSpace(8),
            ShimmerContainer(
              width: 80.w,
              height: 12.h,
              radius: 1.sp,
            ),
          ],
        ),
  );
}
