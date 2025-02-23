import '../data/model/entertainment_model.dart';

abstract class TripStates {}

class TripStatesInitial extends TripStates {}
class TripStatesLoading extends TripStates {}
class TripStatesSuccess extends TripStates {
  final EntertainmentModel tripModel;
  TripStatesSuccess({required this.tripModel});
}
class TripStatesFailure extends TripStates {
  final String errorMsg;
  TripStatesFailure({required this.errorMsg});
}