import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/booking/data/model/bookings_model.dart';

abstract class MyBookingsStates extends Equatable{
  const MyBookingsStates();

  @override
  List<Object> get props => [];
}
class MyBookingsStatesInitial extends MyBookingsStates{
  const MyBookingsStatesInitial();
}
class MyBookingsStatesLoading extends MyBookingsStates{
  const MyBookingsStatesLoading();
}
class MyBookingsStatesSuccess extends MyBookingsStates{
  final List<BookingModel> bookings ;
  const MyBookingsStatesSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];


}
class MyBookingsStatesFailure extends MyBookingsStates{
  final String message ;
  const MyBookingsStatesFailure(this.message);

  @override
  List<Object> get props => [message];
}