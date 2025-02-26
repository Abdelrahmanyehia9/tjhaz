import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import 'package:tjhaz/core/widgets/loading_shimmer.dart';

class EntertainmentGridLoading extends StatelessWidget {
  const EntertainmentGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Makes GridView take only needed space
      physics: const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio:CardSizes.productCard.width / CardSizes.productCard.height,
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) =>  gridItem(),
    ) ;
  }
  Widget gridItem()=>  LoadingShimmerContainer(width: CardSizes.productCard.width, height: CardSizes.productCard.height , radius: 8,) ;
}
