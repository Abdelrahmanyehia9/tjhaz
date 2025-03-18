import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/time_helper.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/containers.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/headlines.dart';
import '../../../../../core/widgets/animation.dart';
import '../../../../../core/widgets/shimmer_container.dart';
import '../../../logic/reservation/get_reservation_hours_cubit.dart';
import '../../../logic/reservation/get_reservation_hours_states.dart';

class SelectStartingTime extends StatefulWidget {
  final int availableFrom;
  final int availableTo;
  final int tripDuration;
final Function(int) onTimeSelected ;
  const SelectStartingTime(
      {super.key,
      required this.availableFrom,
      required this.availableTo,
      required this.tripDuration ,required this.onTimeSelected});

  @override
  State<SelectStartingTime> createState() =>
      _SelectStartingTimeState();
}

class _SelectStartingTimeState extends State<SelectStartingTime> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReservedHoursCubit, GetReservedHoursStates>(
      builder: (context, state) {
        if (state is GetReservedHoursSuccess) {
          List<int> reservedHours = context.read<GetReservedHoursCubit>().reservedHours;

          return Column(
            children: [
              ReservationHeadline(text: AppStrings.startingTime),
              Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: List.generate(
                  (widget.availableTo - widget.availableFrom),
                  (index) {
                    int timeSlot = widget.availableFrom + index;
                    bool isAvailable = !(reservedHours.contains(timeSlot));

                    return SlideFadeTransition(
                      index: index,
                      child: StartingHourContainer(
                        time: TimeHelper.convertTime(timeSlot),
                        onTap: () {
                        widget.onTimeSelected(index) ;
                        },
                        isSelected: context
                                .read<GetReservedHoursCubit>()
                                .startingHoursSelectedIndex ==
                            index,
                        isAvailable: isAvailable,
                      ),
                    );
                  },
                ),
              ),
            ],
          );

        } else if (state is GetReservedHoursInitial) {
          return const SizedBox();
        } else {
          return _buildLoadingShimmer();
        }
      },
    );
  }

  Widget _buildLoadingShimmer() => Padding(
        padding: EdgeInsets.only(top: 48.0.h),
        child: Wrap(
          spacing: 16.w,
          runSpacing: 8.h,
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
}
