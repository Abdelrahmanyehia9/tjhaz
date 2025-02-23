import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/home_repository.dart';
import 'home_trips_states.dart';

class HomeTripsCubit extends Cubit<HomeTripsStates> {
  final HomeRepository homeRepository;

  HomeTripsCubit({required this.homeRepository})
      : super(HomeTripsStatesInitial());

  Future<void> getHomeTrips() async {
    emit(HomeTripsStatesLoading());
    final results = await homeRepository.getTrips();
    results.fold((trips) {
      emit(HomeTripsStatesSuccess(trips)) ;
    }, (error) {
      emit(HomeTripsStatesFailure(error));
    });
  }
}
