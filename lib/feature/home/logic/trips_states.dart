import 'package:tjhaz/feature/home/data/models/home_model.dart';

abstract class TripsStates{}
class TripsStatesInitial extends TripsStates{}
class TripsStatesLoading extends TripsStates{}
class TripsStatesFailure extends TripsStates{
  final String errorMg ;
  TripsStatesFailure({required this.errorMg});
}
class TripsStatesSuccess extends TripsStates{
 final List<HomeModel>trips ;
  TripsStatesSuccess({required this.trips});
}


