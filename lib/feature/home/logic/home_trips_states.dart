import '../data/models/home_model.dart';

abstract class HomeTripsStates {}

class HomeTripsStatesInitial extends HomeTripsStates {}

class HomeTripsStatesLoading extends HomeTripsStates {}

class HomeTripsStatesSuccess extends HomeTripsStates {
  final  List<HomeModel> trips ;
  HomeTripsStatesSuccess(this.trips);
}

class HomeTripsStatesFailure extends HomeTripsStates {
  final String errorMsg ;
  HomeTripsStatesFailure(this.errorMsg);
}