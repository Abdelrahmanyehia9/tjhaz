import 'package:equatable/equatable.dart';

abstract class GetAllFavoriteStates extends Equatable{
  const GetAllFavoriteStates();

  @override
  List<Object> get props => [];
}
class GetAllFavoriteStatesInitial extends GetAllFavoriteStates{}
class GetAllFavoriteStatesLoading extends GetAllFavoriteStates{}
class GetAllFavoriteStatesSuccess extends GetAllFavoriteStates{
  const GetAllFavoriteStatesSuccess();

}
class GetAllFavoriteStatesFailure extends GetAllFavoriteStates{
  final String error ;
  const GetAllFavoriteStatesFailure(this.error);
  @override
  List<Object> get props => [error];
}
