import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/card_sizes.dart';
import '../../../../core/widgets/cards/square_card.dart';
import '../../../../core/widgets/cards/trip_card.dart';
import '../../data/model/entertainment_details_model.dart';

class EntertainmentGrid extends StatelessWidget {
  final List<EntertainmentDetailsModel>items ;
  const EntertainmentGrid({super.key , required this.items});


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: computeGridSize(items[0]),
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      itemBuilder: (context, index) => gridItem(items[index]),
    );
  }
  Widget gridItem(EntertainmentDetailsModel model) {
    return model.facilities != null ? TripCardItem(model: model) : SquareCard(model: model);
  }
  double computeGridSize(EntertainmentDetailsModel model) {
    if (model.facilities!=null ){
      return CardSizes.tripCard.width / CardSizes.tripCard.height;
    }else{
      return CardSizes.squareCard.width/CardSizes.squareCard.height;
    }
  }

}
