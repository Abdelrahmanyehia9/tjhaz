import 'package:equatable/equatable.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';

abstract class CategoriesStates extends Equatable{
  const CategoriesStates();

  @override
  List<Object> get props => [];
}
class CategoriesStateInitial extends CategoriesStates{}
class CategoriesStateLoading extends CategoriesStates{}
class CategoriesStateSuccess extends CategoriesStates{
  final List<CategoryModel> categories ;
  const CategoriesStateSuccess(this.categories);
  @override
  List<Object> get props => [categories];
}
class CategoriesStateFailure extends CategoriesStates{
  final String errorMsg  ;

  const CategoriesStateFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
