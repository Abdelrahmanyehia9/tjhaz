import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/constants.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/core/widgets/app_loading.dart';
import 'package:tjhaz/core/widgets/box_action_button.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/entertainment/logic/trip_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/trip_states.dart';
import 'package:tjhaz/feature/entertainment/view/widget/facilities.dart';
import 'package:tjhaz/feature/entertainment/view/widget/slider.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/utils/screen_size.dart';
import '../../../../core/widgets/app_slider.dart';
import '../../../../core/widgets/icon_and_text.dart';
import '../../helper/facilities_helper.dart';

class TripScreen extends StatefulWidget {
  final String tripID;
  const TripScreen({super.key , required this.tripID});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  void initState() {
      context.read<TripCubit>().getTripById(widget.tripID);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TripCubit , TripStates>(
      builder:  (context , state){
        if(state is TripStatesSuccess){
          return Scaffold(
            bottomNavigationBar: FixedBottomButton(onPressed: (){}) ,
            body: SafeArea(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBackButton(),
                      EntertainmentSlider(imageList:state.tripModel.images),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0 , bottom: 8),
                        child: Text(state.tripModel.name[AppConstants.currentLanguage]! , style: AppTypography.t20Bold.copyWith(color: AppColors.primaryColor),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(title: "${state.tripModel.guests} ${AppLocalizations.guests}" , icon:Icons.person),
                          IconAndText(title: state.tripModel.location?[AppConstants.currentLanguage]??"No specific location",icon:  Icons.location_on),
                          IconAndText(title: state.tripModel.rates , icon: Icons.star) ,
                          horizontalSpace(80)
                        ],),
                      verticalSpace(24) ,
                      facilities(state.tripModel.facilities!),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: 24.0.h),
                        child: Text(AppLocalizations.comfortFacilities , style: AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),),
                      ),
                      comfortFacilities(state.tripModel.comfortFacilities!),
                      Padding(
                        padding:  EdgeInsets.only(top: 16.0.h , bottom: 8.h),
                        child: Text(AppLocalizations.description.toUpperCase() , style: AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),),
                      ),
                      Text(state.tripModel.description[AppConstants.currentLanguage]! ,
                        style: AppTypography.t11Light.copyWith(color: AppColors.lightPrimaryColor.withOpacity(0.7)),
                      ) ,
                      verticalSpace(16)
                    ],
                  ),
                ),
              ),
            ),);
        }
        else if( state is TripStatesFailure){
          return Center(child: Text(state.errorMsg) ) ;
        }else{
          return AppLoading() ;
        }
      },
    );
  }

  Widget seeMore()=>Column(
    children: [
      Container(
        width: 76.w,height: 60.h,
        decoration: BoxDecoration(
            color: AppColors.cWhite,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 0.7 ,
                  blurRadius: 0.7 ,
                  offset: Offset(0 , 1)
              )
            ]
        ),
        child: Icon(Icons.more_horiz , size: 56.sp,color: AppColors.secondaryColor,),
      ),
      verticalSpace(4) ,
      Text(AppLocalizations.viewAll.toUpperCase() , style: AppTypography.t11Bold.copyWith(color: AppColors.secondaryColor),)
    ],
  );
  Widget facilities(Map<String ,dynamic>fac)=> Wrap(
    spacing: 16.w,
    runSpacing: 16.h,
    children: [
      FacilitiesContainer(icon:Icons.person_outline ,title: "${fac[FacilitiesHelper.guests]} ${AppLocalizations.guests}"),
      FacilitiesContainer(icon:Icons.bed_outlined ,title: "${fac[FacilitiesHelper.bedroom]} ${AppLocalizations.bedroom}"),
      FacilitiesContainer(icon:Icons.shower_outlined ,title: "${fac[FacilitiesHelper.bathroom]} ${AppLocalizations.bathroom}"),
      FacilitiesContainer(icon:Icons.closed_caption_outlined ,title: fac[FacilitiesHelper.captain].toString().tr()),
      FacilitiesContainer(icon:Icons.chair_outlined ,title: "${fac[FacilitiesHelper.halls]} ${AppLocalizations.halls}"),
      FacilitiesContainer(icon:Icons.area_chart_outlined ,title: "${fac[FacilitiesHelper.area]} ${AppLocalizations.m2}"),
    ],
  ) ;
  Widget comfortFacilities(List<String> fac){
    if (fac.length > 3){
      return Row(
        children: [
          Wrap(
              spacing: 16.w,
              children: List.generate(3, (item)=> FacilitiesContainer(isComfort: true,
                  icon:FacilitiesHelper.getIcon(fac[item]) ,title: fac[item].tr()))
          ),
          horizontalSpace(16),
          seeMore(),
        ],
      ) ;
    }else{
      return Wrap(
          spacing: 16.w,
          children: List.generate(
              fac.length, (item)=> FacilitiesContainer(isComfort: true,
              icon:FacilitiesHelper.getIcon(fac[item]) ,title: fac[item].tr()))
      ) ;
    }

  }
}
