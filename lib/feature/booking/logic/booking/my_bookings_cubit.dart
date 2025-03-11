import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';

import 'my_bookings_states.dart';

class MyBookingsCubit extends Cubit<MyBookingsStates> {
  final BookingRepository bookingRepository  ;
  MyBookingsCubit(this.bookingRepository) : super(MyBookingsStatesInitial());


  Future<void>getAllBookingsByCategory({required String userId , String? category})async{
    emit(MyBookingsStatesLoading()) ;
    final response = await bookingRepository.getAllBookingsByCategory(userId , category) ;
    response.fold((l) {
      safeEmit(MyBookingsStatesSuccess(l)) ;
    }, (r) {
      safeEmit(MyBookingsStatesFailure(r)) ;
    }) ;
  }
  Future<void>cancelBooking({required String bookingId ,required String userId})async{
   safeEmit(MyBookingsStatesLoading()) ;
try {
   await bookingRepository.cancelBooking(bookingId);
  await getAllBookingsByCategory(userId: userId) ;
}
catch(e){
  print(e.toString()) ;
  safeEmit(MyBookingsStatesFailure(e.firebaseErrorMessage)) ;
}
  }
}