abstract class AddToFavoriteStates{}
class AddToFavoriteInitial extends AddToFavoriteStates{}
class AddToFavoriteLoading extends AddToFavoriteStates{}
class AddToFavoriteSuccess extends AddToFavoriteStates{}
class AddToFavoriteFailure extends AddToFavoriteStates{
  final String error ;
  AddToFavoriteFailure(this.error);

}