import 'package:equatable/equatable.dart';

abstract class AddNewBookingState extends Equatable{
  const AddNewBookingState() ;
  @override
  List<Object> get props => [];
}
class  AddNewBookingInitial extends AddNewBookingState{
  const AddNewBookingInitial();
}
class AddNewBookingLoading extends AddNewBookingState{
  const AddNewBookingLoading();
}
class AddNewBookingSuccess extends AddNewBookingState{
  final String message;
  const AddNewBookingSuccess(this.message);
  @override
  List<Object> get props => [message];
}
class AddNewBookingFailure extends AddNewBookingState{
  final String message;
  const AddNewBookingFailure(this.message);
  @override
  List<Object> get props => [message];
}