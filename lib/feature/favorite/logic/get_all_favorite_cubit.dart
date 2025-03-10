import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/favorite/logic/get_all_favorite_states.dart';

import '../../entertainment/data/model/entertainment_details_model.dart';


class GetAllFavoriteCubit extends Cubit<GetAllFavoriteStates>{
  final FavoriteRepository repository ;
  List<EntertainmentDetailsModel> allFavorites = [] ;
  GetAllFavoriteCubit(this.repository):super(GetAllFavoriteStatesInitial());
  Future<void>get()async{
    safeEmit(GetAllFavoriteStatesLoading()) ;
final results = await repository.getAllFavorites() ;
results.fold((favorites){
  allFavorites = favorites  ;
  safeEmit(GetAllFavoriteStatesSuccess()) ;
},(error){
  safeEmit(GetAllFavoriteStatesFailure(error)) ;
}) ;
  }





}