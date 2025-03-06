import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import '../../../../../core/widgets/app_message.dart';
import '../../../data/model/bookings_model.dart';
import '../../../logic/booking/my_bookings_cubit.dart';

void bookingDialog(BuildContext context , BookingModel booking){
  appDialog(context: context, title: AppStrings
      .bookingCancellation, contentMsg: AppStrings.areYouSureYouWantToCancel ,
      onConfirmed:  (){
        context.read<MyBookingsCubit>().cancelBooking(bookingId: booking.bookingId , userId: booking.userId) ;
        context.pop() ;
      }) ;
}