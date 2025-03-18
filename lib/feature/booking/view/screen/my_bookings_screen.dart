import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/utils/screen_size.dart';
import 'package:tjhaz/core/widgets/check_anonymous.dart';
import 'package:tjhaz/core/widgets/app_headline.dart';
import 'package:tjhaz/core/widgets/toggle_pages.dart';
import 'package:tjhaz/feature/booking/logic/booking/my_bookings_cubit.dart';
import 'package:tjhaz/feature/booking/view/widgets/bookings/my_booking_list.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnonymousScreen(
      ifNotAnonymous: Scaffold(
        body: SafeArea(
          child:  Column(
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric( horizontal: 16.w),
                  child: AppHeadline(
                    tittle: AppStrings.bookings,
                  ),
                ),
                TogglePages(
                  width: 100.w,
                  selectedTextStyle: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
                  unSelectedTextStyle: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
                  pages: List.generate(4, (index)=> MyBookingsList(id: index,)) ,
                  title: [
                    AppStrings.all,
                    AppStrings.trips,
                    AppStrings.wild,
                    AppStrings.activities
                  ],
                  onTap: (index) {
                    context.read<MyBookingsCubit>().getAllBookingsByCategory(category: index == 0 ? null : index.toString()) ;
                  },
                )
              ],
            ),
          ),
        
      ),
    );
  }
}
