import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';

class CartRepository {
  final FirebaseFirestore firestore;

  const CartRepository(this.firestore);

  Future<Either<List<CartModel>, String>> getAllItemsInCart() async {
    try {
      List<CartModel> cartItems = [];
      final response = await firestore
          .collection(FireStoreConstants.userCollection)
          .where("userId", isEqualTo: AppConstants.currentUserID)
          .get();
      final cartResponse =
          await response.docs.first.reference.collection("cart").get();
      for (var item in cartResponse.docs) {
        cartItems.add(CartModel.fromJson(item.data()));
      }
      return left(cartItems);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  // Future<void> addItemsToCart({required CartModel model}) async {
  //   await firestore
  //       .collection(FireStoreConstants.userCollection)
  //       .doc(AppConstants.currentUserID)
  //       .collection("cart")
  //       .doc(model.id)
  //       .set(model.toJson());
  // }
}
