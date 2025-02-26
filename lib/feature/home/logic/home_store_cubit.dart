import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/home/logic/home_store_state.dart';

class HomeStoresCubit extends Cubit<HomeStoreStates>{
  final HomeRepository homeRepository ;

  HomeStoresCubit(this.homeRepository):super(HomeStoreStatesInitial());



  Future<void> getHomeStores() async {
    emit(HomeStoreStatesLoading());
    final results = await homeRepository.getAllStores();
    results.fold((stores) {
      emit(HomeStoreStatesSuccess(stores));
    }, (error) {
      emit(HomeStoreStatesFailure(error));
    });
  }




}