import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/widgets/app_message.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/styles/app_icon.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/errors_widgets.dart';
import '../../../../../core/widgets/shimmer_container.dart';
import '../../../data/model/bookings_model.dart';
import '../../../logic/booking/my_bookings_cubit.dart';
import '../../../logic/booking/my_bookings_states.dart';
import 'my_booking_item_components.dart';

class MyBookingsList extends StatelessWidget {
  const MyBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 575.h,
      child: BlocBuilder<MyBookingsCubit, MyBookingsStates>(
          builder: (context, state) {
            if (state is MyBookingsStatesSuccess) {
              return state.bookings.isEmpty
                  ? EmptyList(
                title: AppStrings.bookings,
                icon: AppIcons.noBooking,
              )
                  : ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    myBookingItem(state.bookings[index], context),
                separatorBuilder: (context, index) => verticalSpace(12),
                itemCount: state.bookings.length,
              );
            } else if (state is MyBookingsStatesFailure) {
              return AppErrorWidget(error: state.message);
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ShimmerContainer(
                  width: double.infinity,
                  height: 120.h,
                  radius: 8,
                ),
                separatorBuilder: (context, index) => verticalSpace(12),
                itemCount: 12,
              );
            }
          }),
    );
  }

  Widget myBookingItem(BookingModel booking, BuildContext context) {
    Widget bookingCard = Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.cWhite,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 0.3,
              blurRadius: 5,
              offset: Offset(0, 1))
        ],
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyBookingInfo(booking: booking),
          verticalSpace(16),
          MyBookingStatusAndPrice(booking: booking),
        ],
      ),
    );

    if (booking.status == "pending") {
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          bookingCard,
          MyBookingCancelButton(booking: booking,),
        ],
      );
    }

    return Slidable(
      endActionPane: ActionPane(

        motion: const ScrollMotion(),
        children: [
          if (booking.status == "completed")
            SlidableAction(

              onPressed: (context) {
                ///share

              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: "share",
              spacing: 0,
            ),
          SlidableAction(
            onPressed: (slidContext) {
              appDialog(context: context, title: "Booking Cancellation", contentMsg: "Are you really want to cancel this booking ?" ,
                  onConfirmed:  (){

                    context.read<MyBookingsCubit>().cancelBooking(bookingId: booking.bookingId , userId: booking.userId) ;
                    context.pop() ;

                  }) ;
            },
            backgroundColor: AppColors.secondaryColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "remove",
            spacing: 0,
          ),
        ],
      ),
      child: bookingCard,
    );
  }
}

