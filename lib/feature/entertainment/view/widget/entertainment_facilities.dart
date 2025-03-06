import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/app_back_button.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_button.dart';
import 'package:tjhaz/feature/home/view/screen/home_layout.dart';
import '../../../../core/helpers/icon_helper.dart';
import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/amenities.dart';
import 'facilities_container.dart';
class EntertainmentFacilities extends StatelessWidget {
  final Map<String, dynamic>entertainmentFacilities;

  final List<String> facilitiesComfortable;

  const EntertainmentFacilities(
      {super.key, required this.entertainmentFacilities, required this.facilitiesComfortable});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        facilities(entertainmentFacilities),
        comfortFacilities(facilitiesComfortable, context)

      ],
    );
  }


  Widget facilities(Map<String, dynamic> fac) =>
      Wrap(
        spacing: 16.w,
        runSpacing: 16.h,
        children: [
          FacilitiesContainer(
              icon: Icons.person_outline,
              title:
              "${fac[Amenities.guests]} ${AppStrings.guests}"),
          FacilitiesContainer(
              icon: Icons.bed_outlined,
              title:
              "${fac[Amenities.bedroom]} ${AppStrings.bedroom}"),
          FacilitiesContainer(
              icon: Icons.shower_outlined,
              title:
              "${fac[Amenities.bathroom]} ${AppStrings.bathroom}"),
          FacilitiesContainer(
              icon: Icons.closed_caption_outlined,
              title: fac[Amenities.captain].toString().tr()),
          FacilitiesContainer(
              icon: Icons.chair_outlined,
              title:
              "${fac[Amenities.halls]} ${AppStrings.halls}"),
          FacilitiesContainer(
              icon: Icons.area_chart_outlined,
              title: "${fac[Amenities.area]} ${AppStrings.m2}"),
        ],
      );
  Widget comfortFacilities(List<String> fac, BuildContext context) {
    if (fac.length > 3) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 24.0.h , bottom: 16.h),
            child: Text(
              AppStrings.comfortFacilities,
              style:
              AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                  spacing: 16.w,
                  children: List.generate(
                      3,
                          (item) =>
                          FacilitiesContainer(
                              isComfort: true,
                              icon: IconHelper.getFacilitiesIcon(fac[item]),
                              title: fac[item].tr()))),
              horizontalSpace(16),
              InkWell(
                  onTap: () {

                    // showModalBottomSheet(context: context, builder: (context) =>  Container(
                    //       width: screenWidth(context),
                    //       color: AppColors.cWhite,
                    //       child: SingleChildScrollView(
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Padding(
                    //                 padding:  EdgeInsets.only(top: 24.0.h , bottom: 16.h),
                    //                 child: Text(AppStrings.comfortFacilities , style: AppTypography.t20Normal.copyWith(color: AppColors.primaryColor),),
                    //               ),
                    //               Wrap(
                    //                   spacing: 16.w,
                    //                   runSpacing: 16.h,
                    //                   children: List.generate(
                    //                       facilitiesComfortable.length,
                    //                           (item) =>
                    //                           FacilitiesContainer(
                    //                               icon: IconHelper.getFacilitiesIcon(fac[item]),
                    //                               title: fac[item].tr()))),
                    //
                    //             ],
                    //           ) ,
                    //           Padding(
                    //             padding:  EdgeInsets.symmetric(vertical: 8.0),
                    //             child: AuthButton(tittle: "close", onPressed: (){
                    //               context.pop() ;
                    //             }),
                    //           )
                    //
                    //         ],),
                    //       ),
                    //     ),);
                  },
                  child: seeMore()),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0.h),
            child: Text(
              AppStrings.comfortFacilities,
              style:
              AppTypography.t16Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
          Wrap(
              spacing: 16.w,
              children: List.generate(
                  fac.length,
                      (item) =>
                      FacilitiesContainer(
                          isComfort: true,
                          icon: IconHelper.getFacilitiesIcon(fac[item]),
                          title: fac[item].tr()))),
        ],
      );
    }
  }
  Widget seeMore() =>
      Column(
        children: [
          Container(
            width: 76.w,
            height: 60.h,
            decoration: BoxDecoration(
                color: AppColors.cWhite,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 0.7,
                      blurRadius: 0.7,
                      offset: Offset(0, 1))
                ]),
            child: Icon(
              Icons.more_horiz,
              size: 56.sp,
              color: AppColors.secondaryColor,
            ),
          ),
          verticalSpace(4),
          Text(
            AppStrings.viewAll.toUpperCase(),
            style:
            AppTypography.t11Bold.copyWith(color: AppColors.secondaryColor),
          )
        ],
      );

}

