import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/trip/data/repository/trip_repository.dart';
import 'package:tjhaz/feature/trip/logic/trip_states.dart';

class TripCubit extends Cubit<TripStates>{
  final TripRepository tripRepository ;
  TripCubit(this.tripRepository) : super(TripStatesInitial());
  Future<void>getTripById(String id)async{
    final result = await tripRepository.getTripByID(tripID: id);
    result.fold((trip){
      emit(TripStatesSuccess(tripModel: trip));
    }, (error){
      emit(TripStatesFailure(errorMsg: error));
    });
  }
}