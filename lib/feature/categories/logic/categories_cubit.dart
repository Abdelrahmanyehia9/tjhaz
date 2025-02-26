import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates>{
  final CategoryRepository repository ;
  int currentIndex = 0 ;

  CategoriesCubit(this.repository):super(CategoriesStateInitial()) ;



  Future<void>getCategoriesByParentId(String parentID)async{
    emit(CategoriesStateLoading()) ;
    final results = await repository.getSubCategoriesByParentID(parentID) ;
    results.fold((categories){
      emit(CategoriesStateSuccess(categories: categories)) ;
    }, (error){
      emit(CategoriesStateFailure(errorMsg: error)) ;
    }) ;



  }





}