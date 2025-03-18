import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/styles/app_gradient.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/core/widgets/cached_image_widget.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/favorite/view/widgets/add_to_favorite.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/styles/card_sizes.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/typography.dart';
import '../../../../../core/widgets/box_icon_button.dart';

class TripCardItem extends StatelessWidget {
  final EntertainmentDetailsModel model ;
  const TripCardItem({super.key ,required this.model});

  @override
  Widget build(BuildContext context) {
    return  CustomGestureDetector(
      onTap: (){
        context.push(AppRouter.entertainmentDetailsScreen , extra:  model) ;
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h , horizontal: 8.w),
        width: CardSizes.tripCard.width,
        height: CardSizes.tripCard.height,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),
            gradient: AppGradient.tripCardGradient
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                      height: 131.h,width: 166.w,
                      child: CachedNetworkImageWidget(imgUrl: model.images.first)
                  ),
                ) ,
                Positioned(
                    top: 8.h, right: 6.h,
                    child: AddToFavorite(id:model.id,))
              ],
            ) ,
            verticalSpace(8),
            Text(model.name.localized , style: AppTypography.t12Bold.copyWith(color: AppColors.primaryColor),) ,
            Text("${AppStrings.startingFrom}: ${model.price.toStringAsFixed(0)} ${AppStrings.kwdCurrency}" , style: AppTypography.t10light.copyWith(color: AppColors.primaryColor),) ,
            Text("( ${AppStrings.perHr} )" , style: AppTypography.t10light.copyWith(color: AppColors.primaryColor),) ,
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                tripOption("${model.guests!} ${AppStrings.guests}" , Icons.person),
                tripOption(model.rates , Icons.star)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                tripOption(model.location.localized , Icons.location_on),
                tripOption("${model.minHoursToBooking} ${AppStrings.hrs.toUpperCase()}" , Icons.access_time_filled_rounded)
              ],
            ),
            const Spacer()
          ],
        ),
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
