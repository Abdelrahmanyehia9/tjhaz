import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/containers.dart';
import 'package:tjhaz/feature/booking/view/widgets/reservation/headlines.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/animation.dart';
import '../../../../entertainment/data/model/entertainment_details_model.dart';
import '../../../logic/reservation/get_reservation_date_cubit.dart';
import '../../../logic/reservation/get_reservation_hours_cubit.dart';
import '../../../logic/reservation/get_reservation_hours_states.dart';

class DurationSelector extends StatelessWidget {
  final EntertainmentDetailsModel model;
  const DurationSelector({super.key ,required this.model});

  @override
  Widget build(BuildContext context) {
    return buildDurationSelector();
  }
  Widget buildDurationSelector() {
    int maxDuration = model.availableTo - model.availableFrom;
    int minDuration = model.minHoursToBooking;
    int availableDuration = maxDuration - minDuration;
    int price = model.price.floor();

    return BlocBuilder<GetReservedHoursCubit, GetReservedHoursStates>(
      builder: (context, state) {
        if (state is GetReservedHoursInitial) {
          return const SizedBox();
        } else {
          return Column(
            children: [
              ReservationHeadline(text : AppStrings.duration),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(availableDuration + 1, (index) {
                    return SlideFadeTransition(
                      index: index,
                      child: CustomGestureDetector(
                        onTap: () {
                          if(index != context.read<GetReservedHoursCubit>().selectedDurationIndex ){
                            context.read<GetReservedHoursCubit>().selectedDurationIndex = index;
                            context.read<GetReservedHoursCubit>().getReservedHours(
                              model: model,
                              duration: minDuration + index,
                              month: context.read<GetReservedDatesCubit>().currentMonth,
                            );
                          }

                        },
                        child: availableDuration == index
                            ? BookingAllDayContainer(
                          isSelected: context.read<GetReservedHoursCubit>().selectedDurationIndex == index,
                          price: price * (minDuration + index),
                        )
                            : DurationContainer(
                          pricePerHour: price * (minDuration + index),
                          isSelected: context.read<GetReservedHoursCubit>().selectedDurationIndex == index,
                          time: (minDuration + index).toString(),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        }
      },
    );
  }

}
