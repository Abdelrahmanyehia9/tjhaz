import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_caching_helper.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/extention/localized_map.dart';
import 'package:tjhaz/feature/categories/data/model/category_model_constants.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';

class CategoryRepository {
  final FirebaseFirestore firestore;

  CategoryRepository(this.firestore);

  Future<Either<List<CategoryModel>, String>> getSubCategoriesByParentID(String id, bool isShopVendors) async {
    try {
      List<CategoryModel> subcategories = [];

      if (isShopVendors) {
        final response = await firestore.getCollectionWithCache(FireStoreConstants.storesCollection);
        for (var item in response.docs) {
          subcategories.add(CategoryModel(
            id: item[CategoryModelConstants.id],
            title: (item[CategoryModelConstants.title] as Map<String, dynamic>).localized,
            pID: "3",
            image: item["images"][0],
          ));
        }
      } else {
        final response = await firestore.getCollectionWithWhereCache(
          FireStoreConstants.categoriesCollection,
          CategoryModelConstants.pID,
          id,
        );
        for (var item in response.docs) {
          subcategories.add(CategoryModel.fromJson(item.data()));
        }
      }
      return left(subcategories);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
}
