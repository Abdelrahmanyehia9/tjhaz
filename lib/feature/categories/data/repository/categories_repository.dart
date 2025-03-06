import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/core/extention/firestore_error_message.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';

class CategoryRepository{
  final FirebaseFirestore firestore ;
  CategoryRepository(this.firestore) ;


  Future<Either<List<CategoryModel> , String>>getSubCategoriesByParentID( String iD  , bool isShopVendors )async{
    try{
      List<CategoryModel> subcategories = [] ;
      if(isShopVendors)
      {
        final response =  await firestore.collection(FireStoreConstants.storesCollection).get() ;
        for(var item in response.docs){
          subcategories.add(CategoryModel(id: item["id"], title: (item["name"]as Map<String,dynamic>).localized, pID: "3"  , image: item["images"][0] )) ;
        }
      } else {
        final response =  await firestore.collection(FireStoreConstants.categoriesCollection).where("pID",isEqualTo: iD).get() ;
         for(var item in response.docs){
          subcategories.add(CategoryModel.fromJson(item.data())) ;
        }
      }
      return left(subcategories) ;
    }catch(e){
      return right(e.firestoreErrorMessage) ;

    }









  }










}