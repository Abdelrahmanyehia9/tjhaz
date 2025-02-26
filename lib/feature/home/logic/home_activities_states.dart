import 'package:equatable/equatable.dart';

import '../data/models/home_model.dart';

abstract class HomeActivitiesStates extends Equatable{
  const HomeActivitiesStates();

  @override
  List<Object> get props => [];
}

class HomeActivitiesStatesInitial extends HomeActivitiesStates {}
class HomeActivitiesStatesLoading extends HomeActivitiesStates {}
class HomeActivitiesStatesSuccess extends HomeActivitiesStates {
  final  List<HomeModel> activities ;
  const HomeActivitiesStatesSuccess(this.activities);

  @override
  List<Object> get props => [activities];
}
class HomeActivitiesStatesFailure extends HomeActivitiesStates {
  final String errorMsg ;
  const HomeActivitiesStatesFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}