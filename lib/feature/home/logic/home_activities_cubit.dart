import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/home/logic/home_activities_states.dart';

import '../data/repository/home_repository.dart';

class HomeActivitiesCubit extends Cubit<HomeActivitiesStates> {
  final HomeRepository homeRepository;
  HomeActivitiesCubit({required this.homeRepository})
      : super(HomeActivitiesStatesInitial());
  Future<void> getHomeActivities() async {
    emit(HomeActivitiesStatesLoading());
    final results = await homeRepository.getActivities();
    results.fold((activities) {
      emit(HomeActivitiesStatesSuccess(activities)) ;
    }, (error) {
      emit(HomeActivitiesStatesFailure(error));
    });
  }
}
