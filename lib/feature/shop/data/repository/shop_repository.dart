import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_caching_helper.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import '../model/product_mode.dart';
import '../model/vendor_model.dart';

class ShopRepository {
  final FirebaseFirestore firestore;

  const ShopRepository({required this.firestore});

  Future<Either<List<VendorModel>, String>> getAllVendors() async {
    try {
      final snapshot = await firestore.getCollectionWithCache(FireStoreConstants.storesCollection);
      final vendors = snapshot.docs.map((doc) {
        return VendorModel.fromJson(doc.data());
      }).toList();
      return left(vendors);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<Either<List<ProductModel>, String>> getAllProductsByVendorID(String vendorId) async {
    try {
      final snapshot = await firestore.getCollectionWithWhereCache(
          FireStoreConstants.productCollection,
          "parent_id",
          vendorId
      );
      final products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
      return left(products);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<Either<List<ProductModel>, String>> getRelatedProducts(ProductModel model) async {
    try {
      final snapshot = await firestore.getCollectionWithWhereCache(
          FireStoreConstants.productCollection,
          "tags",
          model.tags,
          operator: "array-contains-any",
          limit: 5
      );
      final products = snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .where((product) => product.id != model.id)
          .toList();
      return left(products);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
}
