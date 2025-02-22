import '../data/model/trip_model.dart';

abstract class TripStates {}

class TripStatesInitial extends TripStates {}
class TripStatesLoading extends TripStates {}
class TripStatesSuccess extends TripStates {
  final TripModel tripModel;
  TripStatesSuccess({required this.tripModel});
}
class TripStatesFailure extends TripStates {
  final String errorMsg;
  TripStatesFailure({required this.errorMsg});
}