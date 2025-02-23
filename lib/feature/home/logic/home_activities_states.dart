import '../data/models/home_model.dart';

abstract class HomeActivitiesStates {}

class HomeActivitiesStatesInitial extends HomeActivitiesStates {}

class HomeActivitiesStatesLoading extends HomeActivitiesStates {}

class HomeActivitiesStatesSuccess extends HomeActivitiesStates {
  final  List<HomeModel> activities ;
  HomeActivitiesStatesSuccess(this.activities);
}

class HomeActivitiesStatesFailure extends HomeActivitiesStates {
  final String errorMsg ;
  HomeActivitiesStatesFailure(this.errorMsg);
}