import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/home/logic/home_activities_states.dart';

import '../data/repository/home_repository.dart';

class HomeActivitiesCubit extends Cubit<HomeActivitiesStates> {
  final HomeRepository homeRepository;
  HomeActivitiesCubit({required this.homeRepository})
      : super(HomeActivitiesStatesInitial());
  Future<void> getHomeActivities() async {
    safeEmit(HomeActivitiesStatesLoading());
    final results = await homeRepository.getActivities();
    results.fold((activities) {
      safeEmit(HomeActivitiesStatesSuccess(activities)) ;
    }, (error) {
      safeEmit(HomeActivitiesStatesFailure(error));
    });
  }
}
