import 'package:equatable/equatable.dart';

abstract class GetReservedHoursStates extends Equatable{
  const GetReservedHoursStates();

  @override
  List<Object> get props => [];
}
class GetReservedHoursInitial extends GetReservedHoursStates{
  const GetReservedHoursInitial();
}
class GetReservedHoursLoading extends GetReservedHoursStates{
  const GetReservedHoursLoading();
}
class GetReservedHoursSuccess extends GetReservedHoursStates{

  final  List<int>?  reservedHours  ;
  const GetReservedHoursSuccess(this.reservedHours);
  @override
  List<Object> get props => [reservedHours??[]];
}
class GetReservedHoursFailure extends GetReservedHoursStates{
  final String errorMsg ;
  const GetReservedHoursFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}