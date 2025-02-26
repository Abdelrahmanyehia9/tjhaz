import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';

abstract class EntertainmentsStates extends Equatable {
  const EntertainmentsStates();

  @override
  List<Object?> get props => [];
}

class EntertainmentsStatesInitial extends EntertainmentsStates {}

class EntertainmentItemsSuccess extends EntertainmentsStates {
  final List<EntertainmentDetailsModel> items;

  const EntertainmentItemsSuccess(this.items);

  @override
  List<Object?> get props => [items];
}

class EntertainmentItemsLoading extends EntertainmentsStates {}

class EntertainmentItemsFailure extends EntertainmentsStates {
  final String errorMsg;

  const EntertainmentItemsFailure(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
