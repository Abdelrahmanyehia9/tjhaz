import 'package:equatable/equatable.dart';

import '../data/model/entertainment_details_model.dart';

abstract class EntertainmentDetailsStates extends Equatable {
  const EntertainmentDetailsStates();

  @override
  List<Object?> get props => [];
}
class EntertainmentDetailsStatesInitial extends EntertainmentDetailsStates {}
class EntertainmentDetailsStatesLoading extends EntertainmentDetailsStates {}
class EntertainmentDetailsStatesSuccess extends EntertainmentDetailsStates {
  final EntertainmentDetailsModel entertainmentModel;
  const EntertainmentDetailsStatesSuccess(this.entertainmentModel);

  @override
  List<Object?> get props => [entertainmentModel];
}
class EntertainmentDetailsStatesFailure extends EntertainmentDetailsStates {
  final String error;

  const EntertainmentDetailsStatesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
