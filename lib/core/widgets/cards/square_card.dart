import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/favorite/data/model/favorite_model.dart';
import 'package:tjhaz/feature/favorite/logic/add_to_favorite_cubit.dart';
import '../../routes/app_router.dart';
import '../../styles/card_sizes.dart';
import '../../styles/colors.dart';
import '../../styles/typography.dart';
import '../box_icon_button.dart';

class SquareCard extends StatelessWidget {
  final EntertainmentDetailsModel model;

  const SquareCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        InkWell(
          onTap: () {
            context.push(AppRouter.entertainmentDetailsScreen, extra: model);
          },
          child: Container(
            alignment: Alignment.bottomLeft,
            width: CardSizes.squareCard.width,
            height: CardSizes.squareCard.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black45, BlendMode.darken),
                    image: CachedNetworkImageProvider(model.images.first),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: AppTypography.t12Normal
                        .copyWith(color: AppColors.cWhite),
                  ),
                  Text(
                    "${model.price} KWD",
                    style: AppTypography.t10light
                        .copyWith(color: AppColors.cWhite),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 8,
                      ),
                      Text(
                        model.location ,
                        style: AppTypography.t10light
                            .copyWith(color: AppColors.cWhite),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 8.h,
            right: 6.h,
            child: FavouriteIcon(
              onTap: (){
                FavoriteModel favModel = FavoriteModel( model, Timestamp.now()) ;
                context.read<AddToFavoriteCubit>().addToFavorite(favoriteModel: favModel) ;
              },
              size: 16,
            ))
      ],
    );
  }
}
