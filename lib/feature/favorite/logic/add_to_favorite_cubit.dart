import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/favorite/logic/add_to_favorite_states.dart';
import '../../../core/routes/index.dart';
import '../data/model/favorite_model.dart';


class AddToFavoriteCubit extends Cubit<AddToFavoriteStates>{
  final FavoriteRepository favoriteRepository ;
AddToFavoriteCubit(this.favoriteRepository):super(AddToFavoriteInitial()) ;
  Future<void>addToFavorite({required FavoriteModel favoriteModel}) async{
    try{
      emit(AddToFavoriteLoading()) ;
      await favoriteRepository.addToFavorites(favoriteModel: favoriteModel) ;
      emit(AddToFavoriteSuccess()) ;
    }catch(e){
      emit(AddToFavoriteFailure(e.firebaseErrorMessage)) ;
    }





  }



}