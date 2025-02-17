import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/styles/card_sizes.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/typography.dart';
import '../../../../../core/widgets/box_action_button.dart';

class TripCardItem extends StatelessWidget {
  const TripCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(vertical: 8.h , horizontal: 8.w),
      width: CardSizes.tripCard.width,
      height: CardSizes.tripCard.height,
      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff103B53).withOpacity(0.44),
                Colors.white.withOpacity(0.2)
              ]


          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                    height: 131.h,width: 166.w,
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3qTHY9zhrBYpshJIDSekgcHL6-TBQw_kA5g&s" , fit: BoxFit.cover,)),
              ) ,
              Positioned(
                  top: 8.h, right: 6.h,
                  child: BoxActionButton(icon: Icons.favorite , size: 16,))
            ],
          ) ,
          verticalSpace(8),
          Text("La Cabane" , style: AppTypography.t12Bold.copyWith(color: AppColors.primaryColor),) ,
          Text("Starting from 100 KWD" , style: AppTypography.t10light.copyWith(color: AppColors.primaryColor),) ,
          Text("(Per Hr)" , style: AppTypography.t10light.copyWith(color: AppColors.primaryColor),) ,
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              tripOption("17 guests" , Icons.person),
              tripOption("4.5" , Icons.star)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              tripOption("Ras Al Ard Porto" , Icons.location_on),
              tripOption("2 Hrs" , Icons.access_time_filled_rounded)
            ],
          ),
          Spacer()



        ],
      ),
    );
  }
  Widget tripOption(String title ,  IconData icon)=> Row(
    children: [
      Icon(icon , size: 16,) ,
      horizontalSpace(2) ,
      SizedBox(
          width: 50.w,
          child: Text(title  , overflow: TextOverflow.ellipsis, style: AppTypography.t10light.copyWith(color: AppColors.secondaryColor),))
    ],
  ) ;
}
