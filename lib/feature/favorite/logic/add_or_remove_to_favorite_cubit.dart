import 'package:flutter/cupertino.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/favorite/logic/add_or_remove_to_favorite_states.dart';
import '../../../core/routes/index.dart';



class AddOrRemoveToFavoriteCubit extends Cubit<AddOrRemoveToFavoriteStates>{
  final FavoriteRepository favoriteRepository ;
AddOrRemoveToFavoriteCubit(this.favoriteRepository):super(AddOrRemoveToFavoriteInitial()) ;
  Future<void>addToFavorite({required String entertainmentID  }) async{
    try{
      await favoriteRepository.addToFavorites(itemID: entertainmentID) ;
      emit(AddOrRemoveToFavoriteSuccess()) ;
    }catch(e){
      emit(AddOrRemoveToFavoriteFailure(e.firebaseErrorMessage)) ;
    }





  }



}