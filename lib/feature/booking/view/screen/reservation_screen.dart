import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import 'package:tjhaz/core/widgets/calender.dart';
import 'package:tjhaz/feature/booking/data/model/bookings_model.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_date_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_states.dart';
import 'package:tjhaz/feature/booking/view/widgets/booking_bottom_button.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/select_day_in_calender.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../widgets/reservation/duration_selector.dart';
import '../widgets/reservation/headlines.dart';
import '../widgets/reservation/select_start_time.dart';

class ReservationScreen extends StatefulWidget {
  final EntertainmentDetailsModel model;

  const ReservationScreen({super.key, required this.model});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}
class _ReservationScreenState extends State<ReservationScreen> {

  @override
  void initState() {
    context.read<GetReservedDatesCubit>().getReservedDays(entertainmentID: widget.model.id,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<GetReservedHoursCubit,GetReservedHoursStates>(
        builder: (context, state) {
          int? startingHour = context.watch<GetReservedHoursCubit>().startingHoursSelectedIndex;
          double totalPrice = widget.model.price * (context.watch<GetReservedHoursCubit>().selectedDurationIndex + widget.model.minHoursToBooking);

          return BookingBottomButton(
            tittle: AppStrings.next,
            onPressed: startingHour != null
                ? () => onTapFixedButton(totalPrice, startingHour+widget.model.availableFrom)
                : null,
            totalPrice: totalPrice,
          );
        },
      ), body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReservationAppBarHeadline(title: widget.model.name.localized),
            SelectDayInCalender(
              model: widget.model,
            ),
            const CalenderIllustration(),
            DurationSelector(model: widget.model),
            verticalSpace(16),
            SelectStartingTime(
              onTimeSelected: (index) {
                setState(() =>
                context
                    .read<GetReservedHoursCubit>()
                    .startingHoursSelectedIndex = index);
              },
              availableFrom: widget.model.availableFrom,
              availableTo: widget.model.availableTo,
              tripDuration: widget.model.minHoursToBooking +
                  context
                      .read<GetReservedHoursCubit>()
                      .selectedDurationIndex,
            ),
            verticalSpace(16),
          ],
        ),
      ),
    ),
    );
  }

  void onTapFixedButton(double totalPrice  , int startingHour) {
    if(SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous) == true){
      anonymousBottomSheet(context: context) ;
    }else{
context.read<AddNewBookingCubit>().totalPrice = totalPrice;
      String month = context
          .read<GetReservedDatesCubit>()
          .currentMonth;
      int day = context
          .read<GetReservedHoursCubit>()
          .currentDay!;
      int duration = (context
          .read<GetReservedHoursCubit>()
          .selectedDurationIndex) + widget.model.minHoursToBooking;
      BookingModel model = BookingModel(bookingId: "",
          catID: widget.model.entertainmentType,
          name: widget.model.name,
          imgUrl: widget.model.images.first,
          location: widget.model.location,
          guests: widget.model.guests,
          createdAt: Timestamp.fromDate(DateTime.now()),
          date: "${DateTime.now().year} $month $day",
          startTime: startingHour,
          numOfHours: duration,
          entertainmentID: widget.model.id,
          status: "pending",
          userId: FirebaseAuth.instance.currentUser!.uid);
      context.read<AddNewBookingCubit>().model = model;
      context.read<AddNewBookingCubit>().totalPrice = totalPrice;
      context.push(AppRouter.addOnsScreen, extra: widget.model);
    }

  }
}
