import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/card_sizes.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/shimmer_container.dart';

class RelatedProductsLoading extends StatelessWidget {
  const RelatedProductsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(16) ,
        ShimmerContainer(
          width: screenWidth(context) * .7,
          height: 24.h,
          radius: 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: SizedBox(
            height: CardSizes.squareCard.height + 16,
            child: ListView.separated(
                separatorBuilder: (context , index) => horizontalSpace(16),
                padding: EdgeInsets.zero,
                itemCount: 4 ,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    ShimmerContainer(width: CardSizes.squareCard.width, height: CardSizes.squareCard.height , radius: 8,)

            ),
          ),
        ),
      ],
    );
  }
}
