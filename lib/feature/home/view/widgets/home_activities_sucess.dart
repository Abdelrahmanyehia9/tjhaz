import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/app_localization.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../entertainment/logic/entertainment_details_cubit.dart';
import '../../../entertainment/logic/entertainment_details_states.dart';
import '../../data/models/home_model.dart';
import 'home_cards.dart';
import 'home_headline.dart';

class HomeActivitiesSuccess extends StatelessWidget {
  final List<HomeModel> items ;
  const HomeActivitiesSuccess({super.key , required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeadline(title: AppLocalizationsString.topActivities,hasViewMore: true,viewMoreOnTap:(){
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
                title: items[index].name![AppConstants.currentLanguage]!,
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
