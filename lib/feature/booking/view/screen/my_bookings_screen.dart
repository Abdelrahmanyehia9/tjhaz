import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
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
                    hasBackButton: true,
                  ),
                ),
                TogglePages(
                  width: 100.w,
                  pages: List.generate(4, (index)=> MyBookingsList(id: index,)) ,
                  title: [
                    AppStrings.all,
                    AppStrings.trips,
                    AppStrings.wild,
                    AppStrings.activities
                  ],
                  onTap: (index) {
                    context.read<MyBookingsCubit>().getAllBookingsByCategory(userId: FirebaseAuth.instance.currentUser!.uid , category: index == 0 ? null : index.toString()) ;
                  },
                )
              ],
            ),
          ),
        
      ),
    );
  }
}
