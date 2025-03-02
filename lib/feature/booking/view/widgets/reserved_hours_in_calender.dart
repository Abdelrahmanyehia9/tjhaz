import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation_containers.dart';

import '../../../../core/styles/colors.dart';
import '../../../../core/styles/typography.dart';
import '../../../../core/widgets/shimmer_container.dart';
import '../../logic/get_reservation_hours_cubit.dart';
import '../../logic/get_reservation_hours_states.dart';

class ReservedHoursInCalender extends StatefulWidget {
  final int availableFrom ;
  final int availableTo ;
  final int tripDuration ;

  const ReservedHoursInCalender({super.key,required this.availableFrom ,required this.availableTo , required this.tripDuration });

  @override
  State<ReservedHoursInCalender> createState() => _ReservedHoursInCalenderState();
}

class _ReservedHoursInCalenderState extends State<ReservedHoursInCalender> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReservedHoursCubit, GetReservedHoursStates>(
      builder: (context, state) {
        if (state is GetReservedHoursSuccess) {
          return Column(
            children: [
              headline("STARTING TIME"),
              Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                alignment: WrapAlignment.start,
                children: List.generate(
                  (widget.availableTo - widget.availableFrom),
                      (index) {
                    int timeSlot = widget.availableFrom + index;
                    bool isAvailable =
                    !(state.reservedHours?.contains(timeSlot) ?? false);

                    return StartingHourContainer(
                      time: formatTime(timeSlot),
                      onTap: () => setState(() => _selected = index),
                      isSelected: _selected == index,
                      isAvailable: isAvailable,
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is GetReservedHoursFailure) {
          return Center(
            child: Text(
              state.errorMsg,
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return _buildLoadingShimmer();
        }
      },
    );
  }

  /// 🔄 Improved Loading UI
  Widget _buildLoadingShimmer() => Padding(
    padding: EdgeInsets.only(top: 48.0.h),
    child: Wrap(
      spacing: 16.w,
      runSpacing: 8.h,
      alignment: WrapAlignment.start,
      children: List.generate(
        12,
            (index) => ShimmerContainer(
          width: 75.w,
          height: 40.h,
          radius: 6.r,
        ),
      ),
    ),
  );

  String formatTime(int time) {
    if (time >= 12) {
      int hour = (time > 12) ? time - 12 : 12;
      return "${hour.toString().padLeft(2, '0')}:00 PM";
    } else {
      int hour = (time == 0) ? 12 : time;
      return "${hour.toString().padLeft(2, '0')}:00 AM";
    }
  }

  Widget headline(String text) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0.h),
      child: Text(
        text,
        style: AppTypography.t16Normal.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );
}
