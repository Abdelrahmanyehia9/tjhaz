import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/feature/favorite/data/model/favorite_model.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';

import 'favorite_states.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {

  final FavoriteRepository favoriteRepository ;
  List<String> favorites = []  ;
  FavoriteCubit({required this.favoriteRepository}) : super(FavoriteStatesInitial())   ;

  Future<void>getAllFavorites()async{

    safeEmit (GetFavoriteStatesLoading()) ;
    final res = await favoriteRepository.getAllFavorites() ;
    res.fold((favorites){
      safeEmit(GetFavoriteStatesSuccess(favorites)) ;
    }, (error){
      safeEmit(GetFavoriteStatesFailure(error)) ;
    }) ;
  }
  Future<void>addToFavorites({required String itemID})async{

    try{
      favorites.add(itemID) ;
      await favoriteRepository.addToFavorites(itemID: itemID) ;
       safeEmit(AddOrRemoveToFavoriteSuccess()) ;

    }catch(e){
      safeEmit(AddOrRemoveToFavoriteFailure()) ;
    }


     getAllFavorites() ;
}
  Future<void>removeFavorites({required String itemID})async{

    try{
      favorites.remove(itemID) ;
      await favoriteRepository.removeFromFavorites(itemID: itemID) ;
       safeEmit(AddOrRemoveToFavoriteSuccess()) ;

    }catch(e){
      safeEmit(AddOrRemoveToFavoriteFailure()) ;
    }

    getAllFavorites() ;


  }






}