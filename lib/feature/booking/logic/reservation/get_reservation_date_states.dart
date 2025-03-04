import 'package:equatable/equatable.dart';

abstract class GetReservedDatesStates extends Equatable{
  const GetReservedDatesStates();

  @override
  List<Object> get props => [];
}
class GetReservedDatesInitial extends GetReservedDatesStates{
  const GetReservedDatesInitial();
}
class ReservationDatesLoading extends GetReservedDatesStates{
  const ReservationDatesLoading();
}
class GetReservedDateSuccess extends GetReservedDatesStates{

  final List<int>? reservedDates  ;
  const GetReservedDateSuccess(this.reservedDates);
  @override
  List<Object> get props => [reservedDates??[]];
}
class GetReservedDateFailure extends GetReservedDatesStates{
  final String errorMsg ;
  const GetReservedDateFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}