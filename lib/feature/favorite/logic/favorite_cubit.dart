import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';

import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {

  final FavoriteRepository favoriteRepository ;
  Set<String> favoritesIds = {} ;
  List<ProductModel> favProducts = [] ;
  FavoriteCubit(this.favoriteRepository) : super(FavoriteStatesInitial())   ;

  Future<void>getAllFavorites()async{
    safeEmit (GetFavoriteStatesLoading()) ;
    final res = await favoriteRepository.getAllFavorites() ;
    favProducts  = await favoriteRepository.getAllFavoritesProducts() ;
    res.fold((favorites){
      favoritesIds = favorites.map((e) => e.id).toSet() ;
      favoritesIds.addAll(favProducts.map((e) => e.id).toSet()) ;
      safeEmit(GetFavoriteStatesSuccess(favorites)) ;
    }, (error){
      safeEmit(GetFavoriteStatesFailure(error)) ;
    }) ;

  }
  Future<void>addToFavorites({required String itemID})async{

    try{
      safeEmit(AddOrRemoveToFavoriteLoading(itemID)) ;
      await favoriteRepository.addToFavorites(itemID: itemID) ;
       safeEmit(AddOrRemoveToFavoriteSuccess()) ;
      favoritesIds.add(itemID) ;
    }catch(e){
      safeEmit(AddOrRemoveToFavoriteFailure()) ;
    }

}
  Future<void>removeFavorites({required String itemID})async{

    try{
      safeEmit(AddOrRemoveToFavoriteLoading(itemID)) ;
      await favoriteRepository.removeFromFavorites(itemID: itemID) ;
       safeEmit(AddOrRemoveToFavoriteSuccess()) ;
      favoritesIds.remove(itemID) ;
    }catch(e){
      safeEmit(AddOrRemoveToFavoriteFailure()) ;
    }



  }
}