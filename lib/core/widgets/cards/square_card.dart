import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../styles/card_sizes.dart';
import '../../styles/colors.dart';
import '../../styles/typography.dart';
import '../box_action_button.dart';

class SquareCard extends StatelessWidget {
  const SquareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          width: CardSizes.squareCard.width,
          height: CardSizes.squareCard.height,
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
                  image: NetworkImage(
                      "https://arlohotels.com/wp-content/uploads/2019/11/iStock-683130334-scaled.jpg"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("La Cabane" , style: AppTypography.t12Normal.copyWith(color: AppColors.cWhite),),
                Text("300 KWD" , style: AppTypography.t10light.copyWith(color: AppColors.cWhite),),
                Row(
                  children: [
                    Icon(Icons.location_on , color: Colors.white , size: 8,) ,
                    Text("Ras Al Ard Porto" , style: AppTypography.t10light.copyWith(color: AppColors.cWhite),),

                  ],

                )


              ],
            ),
          ),
        ),
        Positioned(
            top: 8.h,
            right: 6.h,
            child: BoxActionButton(
              icon: Icons.favorite,
              size: 16,
            ))
      ],
    );
  }
}

