import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/calender.dart';
import '../../../../core/widgets/shimmer_container.dart';
import '../../logic/get_reservation_date_cubit.dart';
import '../../logic/get_reservation_date_states.dart';
import '../../logic/get_reservation_hours_cubit.dart';

class ReservedDatesInCalender extends StatelessWidget {
  final String entertainmentID;

  const ReservedDatesInCalender({super.key, required this.entertainmentID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReservedDatesCubit, GetReservedDatesStates>(
        builder: (context, state) {
          if (state is GetReservedDateSuccess) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),

                color: const Color(0xffD9D9D9 ).withOpacity(0.2),
              ),
              child: AppCalender(
                onDateSelected: (selectedDate){
                  String month = context.read<GetReservedDatesCubit>().currentMonth ;
                  context.read<GetReservedHoursCubit>().currentDay = selectedDate.day ;
                  context.read<GetReservedHoursCubit>().getReservedHours(entertainmentID: entertainmentID, month: month) ;
                },
                onChanged: (month) {
                  context.read<GetReservedDatesCubit>().currentMonth = month;
                  context
                      .read<GetReservedDatesCubit>()
                      .getReservedDays(entertainmentID: entertainmentID);
                },
                reservedDays: {
                  context.read<GetReservedDatesCubit>().currentMonth:
                  state.reservedDates ?? []
                },
                initialMonth: context.read<GetReservedDatesCubit>().currentMonth,
                disabledFillColor: const Color(0xffE0E0E0),
                enabledFillColor: const Color(0xffE0E0E0),
              ),
            );
          } else if (state is GetReservedDateFailure) {
            return Text(
              state.errorMsg,
            );
          } else {
            return loadingCalender();
          }
        });
  }

  Widget loadingCalender() => ShimmerContainer(
    width: double.infinity,
    height: 360.h,
    radius: 8,
  );
}
