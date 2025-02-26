import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/home/data/models/home_model.dart';

abstract class HomeStoreStates extends Equatable{
  const HomeStoreStates();
  @override
  List<Object?> get props => [];
}
class HomeStoreStatesInitial extends HomeStoreStates{}
class HomeStoreStatesLoading extends HomeStoreStates{}
class HomeStoreStatesSuccess extends HomeStoreStates{
  final List<HomeModel> stores ;
  const HomeStoreStatesSuccess(this.stores);
  @override
  List<Object?> get props => [stores];
}
class HomeStoreStatesFailure extends HomeStoreStates{
  final String error ;
  const HomeStoreStatesFailure(this.error);
  @override
  List<Object?> get props => [error];
}