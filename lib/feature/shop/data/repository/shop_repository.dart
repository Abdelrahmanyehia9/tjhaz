import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firestore_error_message.dart';
import 'package:tjhaz/feature/shop/data/model/vendor_model.dart';

import '../model/product_mode.dart';

class ShopRepository {
  final FirebaseFirestore firestore;

  const ShopRepository({required this.firestore});

  Future<Either<List<VendorModel>, String>> getAllVendors() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FireStoreConstants.storesCollection)
          .get();
      List<VendorModel> vendors = snapshot.docs.map((doc) {
        return VendorModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return left(vendors);
    } catch (e) {
      print(e.toString());
      return right(e.firestoreErrorMessage);
    }
  }

  Future<Either<List<ProductModel>, String>> getAllProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FireStoreConstants.productCollection)
          .get();
      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return left(products);
    } catch (e) {
      return right(e.firestoreErrorMessage);
    }
  }
  Future<Either<List<ProductModel>, String>> getAllProductsByVendorID(
      String vendorId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FireStoreConstants.productCollection)
          .where("parent_id" , isEqualTo: vendorId)
          .get();
      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return left(products);
    } catch (e) {
      print(e.toString()) ;
      return right(e.firestoreErrorMessage);
    }
  }
  Future<Either<List<ProductModel>, String>> getRelatedProducts(ProductModel model) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FireStoreConstants.productCollection)
          .where("tags" , arrayContainsAny:model.tags ).limit(4)
          .get();
      List<ProductModel> products = snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
      }).where((product) => product.id != model.id).toList();;
      return left(products);
    } catch (e) {
      return right(e.firestoreErrorMessage);
    }
  }
}
