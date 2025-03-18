import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/categories_states.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';

import '../data/model/cateory_model.dart';

class CategoriesCubit extends Cubit<CategoriesStates>{
  final CategoryRepository categoryRepository ;
  int activeMainCategoryIndex = 0 ;

  CategoriesCubit(this.categoryRepository ):super(CategoriesStateInitial()) ;
  Future<void>getCategoriesByParentId(String parentID)async{
    safeEmit(CategoriesStateLoading()) ;

    final results = await categoryRepository.getSubCategoriesByParentID(parentID , activeMainCategoryIndex==3) ;
    results.fold((results){
      safeEmit(CategoriesStateSuccess(results)) ;
    }, (error){
      safeEmit(CategoriesStateFailure(errorMsg: error)) ;
    }) ;



  }





}