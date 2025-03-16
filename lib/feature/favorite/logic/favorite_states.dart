import 'package:tjhaz/core/routes/index.dart';

abstract class FavoriteStates{
  const FavoriteStates () ;
}
class FavoriteStatesInitial extends FavoriteStates{}
class GetFavoriteStatesLoading extends FavoriteStates{}
class GetFavoriteStatesSuccess extends FavoriteStates{
  final List<EntertainmentDetailsModel> favorites ;
  const GetFavoriteStatesSuccess(this.favorites) ;
}
class GetFavoriteStatesFailure extends FavoriteStates{
  final String error ;
  const GetFavoriteStatesFailure(this.error) ;
}
class AddOrRemoveToFavoriteSuccess extends FavoriteStates{}
class AddOrRemoveToFavoriteLoading extends FavoriteStates{
  final String loadingID ;
  const AddOrRemoveToFavoriteLoading(this.loadingID)   ;
}
class AddOrRemoveToFavoriteFailure extends FavoriteStates{}
