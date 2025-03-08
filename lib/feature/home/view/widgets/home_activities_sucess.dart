import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../entertainment/logic/entertainment_details_cubit.dart';
import '../../../entertainment/logic/entertainment_details_states.dart';
import '../../data/models/home_model.dart';
import 'home_cards.dart';
import 'headline_view_more.dart';

class HomeActivitiesSuccess extends StatelessWidget {
  final List<HomeModel> items ;
  const HomeActivitiesSuccess({super.key , required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadlineViewMore(title: AppStrings.topActivities,hasViewMore: true,viewMoreOnTap:(){
          context.push(AppRouter.entertainmentScreen , extra: {"parent":AppConstants.categories[2] }) ;
        } ,),
        SizedBox(
          height: screenHeight(context) * 0.175,
          child: ListView.builder(
            itemCount: items.length ,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>  BlocListener<EntertainmentDetailsCubit , EntertainmentDetailsStates>(
              listener: (context , state){
                if(state is EntertainmentDetailsStatesSuccess){


                  GoRouter.of(context).pushReplacement(
                      AppRouter.entertainmentDetailsScreen,
                      extra: state.entertainmentModel
                  );
                }
              },
              child: CardV2(
                imgUrl: items[index].imgUrl,
                title: items[index].name!,
                onTap: () async{
                  context.loaderOverlay.show() ;
                  await context.read<EntertainmentDetailsCubit>().findEntertainmentByID(items[index].id) ;
                  if(context.mounted){
                    context.loaderOverlay.hide() ;
                  }

                },
              ),
            ),
          ),
        ),

      ],
    );
  }
}
