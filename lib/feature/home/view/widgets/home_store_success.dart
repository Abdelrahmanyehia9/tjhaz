import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/extention/localized_map.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/screen_size.dart';
import '../../data/models/home_model.dart';
import 'home_cards.dart';
import 'headline_view_more.dart';

class HomeStoreSuccess extends StatelessWidget {
  final List<HomeModel> items ;
  const HomeStoreSuccess({super.key , required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineViewMore(
          title: AppStrings.topStore,
          hasViewMore: true,
          viewMoreOnTap: (){
            context.push(AppRouter.shopScreen) ;
          },
        ),
        SizedBox(
          height: screenHeight(context) * .175,
          child: ListView.builder(
            itemCount: items.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CardV2(
                imgUrl: items[index].imgUrl,
                title: items[index].name!.localized,
                onTap: () {
                  context.push(AppRouter.shopScreen , extra: index);

                }),
          ),
        ),
      ],
    );
  }
}
