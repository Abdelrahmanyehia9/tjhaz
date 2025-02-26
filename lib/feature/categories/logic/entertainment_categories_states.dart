import 'package:equatable/equatable.dart';

import '../data/model/cateory_model.dart';

abstract class EntertainmentCategoriesStates extends Equatable{

  const EntertainmentCategoriesStates();
  @override
  List<Object?> get props => [];
}
class EntertainmentCategoriesStatesSuccess extends EntertainmentCategoriesStates{
  final List<CategoryModel> categories ;
  const EntertainmentCategoriesStatesSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}
class EntertainmentCategoriesStatesLoading extends EntertainmentCategoriesStates{}
class EntertainmentCategoriesStatesInitial extends EntertainmentCategoriesStates{}
class EntertainmentCategoriesStatesFailure extends EntertainmentCategoriesStates{
  final String error ;
 const EntertainmentCategoriesStatesFailure(this.error);

  @override
  List<Object?> get props => [error];
}