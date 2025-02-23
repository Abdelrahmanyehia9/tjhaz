import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/entertainment/data/repository/activity_repository.dart';
import 'package:tjhaz/feature/entertainment/logic/activity_state.dart';

class ActivityCubit extends Cubit<ActivityStates> {

  ActivityRepository activityRepository ;
  ActivityCubit({required this.activityRepository}) : super(ActivityStatesInitial());
  Future<void>getActivityByID(String id)async{
    final result = await activityRepository.getActivityByID(id);
    result.fold((activity){
      emit(ActivityStatesSuccess( activity));
    }, (error){
      emit(ActivityStatesFailure(error));
    });
  }
}