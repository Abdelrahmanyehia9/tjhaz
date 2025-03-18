import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/booking/data/model/bookings_model.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/booking/add_new_booking_states.dart';

class AddNewBookingCubit extends Cubit<AddNewBookingState>{
   BookingModel? model ;
   double totalPrice = 0 ;

  final BookingRepository bookingRepository  ;
  AddNewBookingCubit(this.bookingRepository):super(const AddNewBookingInitial());


  Future<void>addBook()async{
    safeEmit(const AddNewBookingLoading());
    try{
      if(model == null) throw AppStrings.genericError ;
     final bool hasPendingBooking =  await bookingRepository.hasPendingBooking(model!.userId) ;
     if(hasPendingBooking) throw AppStrings.havePendingBooking ;
     model!.totalPrice = totalPrice ;
      await bookingRepository.bookingNewEntertainment(model!)  ;
      safeEmit(AddNewBookingSuccess(AppStrings.bookingConfirmed)) ;

    }
    catch(e){
      final String error  ;
      if(e is FirebaseException){
        error = e.firebaseErrorMessage ;
      }
      else{
        error = e.toString() ;
      }
      safeEmit(AddNewBookingFailure(error)) ;
    }



  }




}