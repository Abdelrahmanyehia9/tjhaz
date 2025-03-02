import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/helpers/spacing.dart';
import 'package:tjhaz/core/styles/typography.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/core/widgets/calender.dart';
import 'package:tjhaz/core/widgets/fixed_bottom_button.dart';
import 'package:tjhaz/feature/booking/logic/get_reservation_date_cubit.dart';
import 'package:tjhaz/feature/booking/logic/get_reservation_hours_cubit.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import '../../../../core/styles/colors.dart';
import '../widgets/reservation_containers.dart';
import '../widgets/reservation_headline.dart';
import '../widgets/reserved_dates_in_calender.dart';
import '../widgets/reserved_hours_in_calender.dart';

class ReservationScreen extends StatefulWidget {
  final EntertainmentDetailsModel model;

  const ReservationScreen({super.key, required this.model});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int _activeDurationIndex = 0;

  @override
  void initState() {
    context.read<GetReservedDatesCubit>().getReservedDays(
          entertainmentID: widget.model.id,
        );
    String currentMonth = context.read<GetReservedDatesCubit>().currentMonth;
    context.read<GetReservedHoursCubit>().getReservedHours(
          entertainmentID: widget.model.id,
          month: currentMonth,
        );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: fixedBottomButton(34.00),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReservationHeadline(title: widget.model.name),
              ReservedDatesInCalender(
                entertainmentID: widget.model.id,
              ),
              CalenderIllustration(),
              headline("DURATION"),
              buildDurationSelector(),
              verticalSpace(16),
              ReservedHoursInCalender(
                availableFrom: widget.model.availableFrom,
                availableTo: widget.model.availableTo,
                tripDuration: widget.model.minHoursToBooking+_activeDurationIndex,
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget headline(String text) => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h),
          child: Text(
            text,
            style:
                AppTypography.t16Normal.copyWith(color: AppColors.primaryColor),
          ),
        ),
      );

  Widget fixedBottomButton(double totalPrice) {
    return FixedBottomButton(
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "CHECK OUT",
            style: AppTypography.t16Bold.copyWith(color: AppColors.cWhite),
          ),
          Text(
            "Total: ${totalPrice.toStringAsFixed(2)} ${AppStrings.kwdCurrency}",
            style: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
          ),
        ],
      ),
    );
  }

  Widget buildDurationSelector() {
    int maxDuration = widget.model.availableTo - widget.model.availableFrom ;
    int minDuration = widget.model.minHoursToBooking;
    int availableDuration = maxDuration - minDuration;
    int price = widget.model.price.floor();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...List.generate(availableDuration + 1, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _activeDurationIndex = index;
                });
              },
              child:availableDuration == index ?BookingAllDayContainer(isSelected: _activeDurationIndex == index , price: price * (minDuration + index),) :  DurationContainer(
                pricePerHour: price * (minDuration + index),
                isSelected: _activeDurationIndex == index,
                time: (minDuration + index).toString(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

//
// class ReservationScreen extends StatefulWidget {
//   final EntertainmentDetailsModel entertainmentModel;
//
//   const ReservationScreen({super.key, required this.entertainmentModel});
//
//   @override
//   State<ReservationScreen> createState() => _ReservationScreenState();
// }
//
// class _ReservationScreenState extends State<ReservationScreen> {
//   int _currentIndex = 0;
//   late String currentMonth;
//   int? selectedDate;
//   int? selectedStartHour;
//   int selectedDuration = 1;
//   List<int> selectedHours = [];
//   late double totalPrice;
//
//   @override
//   void initState() {
//     super.initState();
//     currentMonth = DateFormat('MMM').format(DateTime.now()).toLowerCase();
//     totalPrice = widget.entertainmentModel.price;
//     _fetchReservations();
//   }
//
//   void _fetchReservations() {
//     context.read<ReservationDateCubit>().getEntertainmentReservationInMonth(
//       entertainmentID: widget.entertainmentModel.id,
//       month: currentMonth,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ReservationDateCubit, ReservationDateState>(
//       builder: (context, state) {
//         if (state is ReservationDateStatesSuccess) {
//           return buildReservationContent(state);
//         } else if (state is ReservationStatesFailure) {
//           return Scaffold(body: Center(child: AppErrorWidget(error: state.errorMsg)));
//         } else {
//           return Scaffold(body: LottieAnimation());
//         }
//       },
//     );
//   }
//
//   Widget buildReservationContent(ReservationDateStatesSuccess state) {
//     return Scaffold(
//       bottomNavigationBar: bottomFixedButton(state.reservationModel),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ReservationHeadline(title: widget.entertainmentModel.name),
//               buildCalendar(state),
//               headline("DURATION"),
//               buildDurationSelector(),
//               headline("STARTING TIME"),
//               buildStartingTimeSelector(state),
//               verticalSpace(16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   }
//
//   Widget buildDurationSelector() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(10, (index) {
//           return InkWell(
//             onTap: () {
//               setState(() {
//                 selectedDuration = index + 1;
//                 selectedHours.clear();
//               });
//             },
//             child: DurationContainer(
//               pricePerHour: widget.entertainmentModel.price.floor() * (index + 1),
//               isSelected: selectedDuration == (index + 1),
//               time: (index + 1).toString(),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//
//
//
//
//   Widget bottomFixedButton(ReservationModel model) {
//     bool isSlotAvailable = selectedHours.isNotEmpty &&
//         selectedHours.every((hour) =>
//         !(model.reservedHours?[selectedDate.toString()]?.contains(hour) ?? false));
//
//     return FixedBottomButton(
//       onPressed: isSlotAvailable ? () {} : null,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             "CHECK OUT",
//             style: AppTypography.t16Bold.copyWith(color: AppColors.cWhite),
//           ),
//           Text(
//             "Total: ${totalPrice.toStringAsFixed(2)} ${AppStrings.kwdCurrency}",
//             style: AppTypography.t14Normal.copyWith(color: AppColors.cWhite),
//           ),
//         ],
//       ),
//     );
//   }
// }
