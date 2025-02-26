import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmerContainer extends StatelessWidget {
  final double height ;
  final double width ;
  final double? radius ;
  const LoadingShimmerContainer({super.key , required this.width , required this.height  ,  this.radius});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0 ),
        color: Colors.grey
      )
    ));
  }
}
