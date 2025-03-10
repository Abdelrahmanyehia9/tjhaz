abstract class AddOrRemoveToFavoriteStates{}
class AddOrRemoveToFavoriteInitial extends AddOrRemoveToFavoriteStates{}
class AddOrRemoveToFavoriteSuccess extends AddOrRemoveToFavoriteStates{}
class AddOrRemoveToFavoriteFailure extends AddOrRemoveToFavoriteStates{
  final String error ;
 AddOrRemoveToFavoriteFailure(this.error);

}