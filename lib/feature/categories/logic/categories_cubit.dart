import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/utils/constants.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';

import '../data/model/cateory_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates>{
  final CategoryRepository categoryRepository ;
  int activeMainCategoryIndex = 0 ;

  CategoriesCubit(this.categoryRepository ):super(CategoriesStateInitial()) ;
  Future<void>getCategoriesByParentId(String parentID)async{
    emit(CategoriesStateLoading()) ;

    final results = await categoryRepository.getSubCategoriesByParentID(parentID , activeMainCategoryIndex==3) ;
    results.fold((results){
      emit(CategoriesStateSuccess(results)) ;
    }, (error){
      emit(CategoriesStateFailure(errorMsg: error)) ;
    }) ;



  }





}