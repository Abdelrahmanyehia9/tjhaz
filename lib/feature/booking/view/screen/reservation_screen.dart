import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/routes/app_router.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/calender.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_date_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_states.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation_bottom_button.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/select_day_in_calender.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
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
    context.read<GetReservedDatesCubit>().getReservedDays(
          entertainmentID: widget.model.id,
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<GetReservedHoursCubit, GetReservedHoursStates>(
        builder: (context, state) {
          int? startingHour = context.watch<GetReservedHoursCubit>().startingHoursSelectedIndex;
          double totalPrice = widget.model.price * (context.watch<GetReservedHoursCubit>().selectedDurationIndex + widget.model.minHoursToBooking);

          return ReservationBottomButton(
            tittle: AppStrings.next,
            onPressed: startingHour != null
                ? () {

              String month = context.read<GetReservedDatesCubit>().currentMonth;
              int day = context.read<GetReservedHoursCubit>().currentDay;
              int duration = (context.read<GetReservedHoursCubit>().selectedDurationIndex) + widget.model.minHoursToBooking;

              print("Month: $month");
              print("Day: $day");
              print("Duration: $duration");
              print("Starting Hour: $startingHour");

              context.push(AppRouter.addOnsScreen, extra:  widget.model   ) ;
            }
                : null,
            totalPrice: totalPrice,
          );
        },
      ),      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReservationAppBarHeadline(title: widget.model.name),
              SelectDayInCalender(
                model: widget.model,
              ),
              CalenderIllustration(),
              DurationSelector(model: widget.model),
              verticalSpace(16),
              SelectStartingTime(
                onTimeSelected: (index){
                  setState(() => context.read<GetReservedHoursCubit>().startingHoursSelectedIndex = index  ) ;

                },
                availableFrom: widget.model.availableFrom,
                availableTo: widget.model.availableTo,
                tripDuration: widget.model.minHoursToBooking +
                    context.read<GetReservedHoursCubit>().selectedDurationIndex,
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
