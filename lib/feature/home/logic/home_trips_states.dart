import 'package:equatable/equatable.dart';

import '../data/models/home_model.dart';

abstract class HomeTripsStates extends Equatable{
  const HomeTripsStates();
  @override
  List<Object?> get props => [];
}
class HomeTripsStatesInitial extends HomeTripsStates {}
class HomeTripsStatesLoading extends HomeTripsStates {}
class HomeTripsStatesSuccess extends HomeTripsStates {
  final  List<HomeModel> trips ;
  const HomeTripsStatesSuccess(this.trips);
  @override
  List<Object?> get props => [trips];
}
class HomeTripsStatesFailure extends HomeTripsStates {
  final String errorMsg ;
  const HomeTripsStatesFailure(this.errorMsg);
  @override
  List<Object?> get props => [errorMsg];
}