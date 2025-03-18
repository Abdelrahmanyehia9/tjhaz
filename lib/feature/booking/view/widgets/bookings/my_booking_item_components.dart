
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/core/widgets/app_gestur_detector.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/helpers/time_helper.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/styles/typography.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/app_message.dart';
import '../../../../../core/widgets/icon_and_text.dart';
import '../../../data/model/bookings_model.dart';
import '../../../logic/booking/my_bookings_cubit.dart';
import 'booking_dialoge.dart';

class MyBookingInfo extends StatelessWidget {
  final BookingModel booking;

  const MyBookingInfo({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(
            width: 90.w,
            height: 90.h,
            child: Image.network(
              booking.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        horizontalSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.name.localized,
              style:
              AppTypography.t12Bold.copyWith(color: AppColors.primaryColor),
            ),
            verticalSpace(8),
            MyBookingTimeDetails(booking: booking),
            verticalSpace(3),
            MyBookingExtraDetails(booking: booking),
          ],
        ),
      ],
    );
  }
}
class MyBookingTimeDetails extends StatelessWidget {
  final BookingModel booking;

  const MyBookingTimeDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          style:
          AppTypography.t10Bold.copyWith(color: AppColors.secondaryColor),
          TextSpan(
            text: AppStrings.date.toUpperCase(),
            children: [
              TextSpan(
                style: AppTypography.t10Normal
                    .copyWith(color: AppColors.primaryColor),
                text: "\t/ ${booking.date}",
              ),
            ],
          ),
        ),
        verticalSpace(3),
        Row(
          children: [
            Text.rich(
              style: AppTypography.t10Bold
                  .copyWith(color: AppColors.secondaryColor),
              TextSpan(
                text: AppStrings.startingTime.toUpperCase(),
                children: [
                  TextSpan(
                    style: AppTypography.t10Normal
                        .copyWith(color: AppColors.primaryColor),
                    text: "\t/ ${TimeHelper.convertTime(booking.startTime)}",
                  ),
                ],
              ),
            ),
            horizontalSpace(8),
            Text.rich(
              style: AppTypography.t10Bold
                  .copyWith(color: AppColors.secondaryColor),
              TextSpan(
                text: AppStrings.end.toUpperCase(),
                children: [
                  TextSpan(
                    style: AppTypography.t10Normal
                        .copyWith(color: AppColors.primaryColor),
                    text:
                    "\t/ ${TimeHelper.convertTime(booking.startTime + booking.numOfHours)}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class MyBookingExtraDetails extends StatelessWidget {
  final BookingModel booking;

  const MyBookingExtraDetails({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconAndTextHorizontal(
          icon: Icons.location_on,
          title: "${booking.location}",
          iconSize: 14.sp,
          iconColor: AppColors.secondaryColor,
          textColor: AppColors.primaryColor,
        ),
        horizontalSpace(8),
        IconAndTextHorizontal(
          icon: Icons.person,
          title: "${booking.guests}",
          iconSize: 14.sp,
          iconColor: AppColors.secondaryColor,
          textColor: AppColors.primaryColor,
        ),
        horizontalSpace(8),
        IconAndTextHorizontal(
          icon: Icons.timelapse_sharp,
          title: "${booking.numOfHours} ${AppStrings.hrs}",
          iconSize: 14.sp,
          iconColor: AppColors.secondaryColor,
          textColor: AppColors.primaryColor,
        ),
      ],
    );
  }
}
class MyBookingStatusAndPrice extends StatelessWidget {
  final BookingModel booking;

  const MyBookingStatusAndPrice({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text.rich(
          style:
          AppTypography.t11Bold.copyWith(color: AppColors.secondaryColor),
          TextSpan(
            text: "${AppStrings.totalPrice}/",
            children: [
              TextSpan(
                style: AppTypography.t10Normal
                    .copyWith(color: AppColors.primaryColor),
                text: "\t${booking.totalPrice} ${AppStrings.kwdCurrency}",
              ),
            ],
          ),
        ),
        horizontalSpace(16),
        Text.rich(
          style:
          AppTypography.t11Bold.copyWith(color: AppColors.secondaryColor),
          TextSpan(
            text: AppStrings.status + "/".toUpperCase(),
            children: [
              TextSpan(
                style: AppTypography.t10Bold.copyWith(
                  color: booking.status == "pending"
                      ? const Color(0xffFBC500)
                      : booking.status == "completed"
                      ? Colors.green
                      : booking.status == "cancelled"
                      ? Colors.red
                      : Colors.black,
                ),
                text: "\t${booking.status.tr()}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class MyBookingCancelButton extends StatelessWidget {
  final BookingModel booking;

  const MyBookingCancelButton({super.key, required this.booking, });

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: () {
        bookingDialog(context  , booking) ;
        },
      child: Container(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        width: 55.w,
        height: 16.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.secondaryColor),
        ),
        child: Text(
          AppStrings.cancel.toUpperCase(),
          style:
          AppTypography.t10Normal.copyWith(color: AppColors.secondaryColor),
        ),
      ),
    );
  }
}