import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/home/logic/trips_states.dart';

import '../data/repository/home_repository.dart';

class TripsCubit extends Cubit<TripsStates>{

  final HomeRepository homeRepository ;
  TripsCubit({required this.homeRepository}):super(TripsStatesInitial()) ;



  Future<void>getAllTrips()async{
    emit(TripsStatesLoading()) ;
    final results = await homeRepository.getHomeTrips() ;
    results.fold((trips){
      emit(TripsStatesSuccess(trips: trips));
    }, (error){
      emit(TripsStatesFailure(errorMg: error)) ;
    });

  }





}