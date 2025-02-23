import 'package:tjhaz/feature/entertainment/data/model/entertainment_model.dart';

abstract class ActivityStates{}

class ActivityStatesInitial extends ActivityStates{}

class ActivityStatesLoading extends ActivityStates{}

class ActivityStatesSuccess extends ActivityStates{
  EntertainmentModel activity ;
  ActivityStatesSuccess(this.activity);
}

class ActivityStatesFailure extends ActivityStates{
  String errorMessage ;
  ActivityStatesFailure(this.errorMessage);
}
