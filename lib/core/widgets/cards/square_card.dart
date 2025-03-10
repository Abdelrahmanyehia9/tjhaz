import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import '../../../feature/favorite/view/widgets/add_to_favorite.dart';
import '../../routes/app_router.dart';
import '../../styles/card_sizes.dart';
import '../../styles/colors.dart';
import '../../styles/typography.dart';

class SquareCard extends StatefulWidget {
  final EntertainmentDetailsModel model;

  const SquareCard({super.key, required this.model});

  @override
  State<SquareCard> createState() => _SquareCardState();
}

class _SquareCardState extends State<SquareCard> {
  @override
  void initState() {
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        InkWell(
          onTap: () {
            context.push(AppRouter.entertainmentDetailsScreen, extra: widget.model);
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
                    image: CachedNetworkImageProvider(widget.model.images.first),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.name,
                    style: AppTypography.t12Normal
                        .copyWith(color: AppColors.cWhite),
                  ),
                  Text(
                    "${widget.model.price} KWD",
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
                        widget.model.location ,
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
            child:AddToFavorite(id: widget.model.id,)
        )
      ],
    );
  }
}
