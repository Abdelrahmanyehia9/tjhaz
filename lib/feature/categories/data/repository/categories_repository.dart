import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';

class CategoryRepository{
  final FirebaseFirestore firestore ;
  CategoryRepository(this.firestore) ;


  Future<Either<List<CategoryModel> , String>>getSubCategoriesByParentID(String iD)async{
    try{
      List<CategoryModel> subcategories = [] ;
      final response = await firestore.collection(FireStoreConstants.categoriesCollection).where("pID",isEqualTo: iD).get() ;
      for(var item in response.docs){
        subcategories.add(CategoryModel.fromJson(item.data())) ;
      }
      return left(subcategories) ;
    }catch(e){
      print(e);
      if(e is FirebaseException){
        return right(FirestoreErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirestoreErrorHandler.getErrorMessage(e.toString())) ;
      }
    }









  }










}