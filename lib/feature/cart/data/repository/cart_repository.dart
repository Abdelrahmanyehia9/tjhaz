import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model.dart';
import 'package:tjhaz/feature/cart/data/model/cart_model_constants.dart';

class CartRepository {
  final FirebaseFirestore firestore;

  final  CollectionReference<Map<String, dynamic>> cartCollection = FirebaseFirestore.instance.collection(FireStoreConstants.userCollection).doc(AppConstants.currentUserID).collection(FireStoreConstants.cartCollection);

   CartRepository(this.firestore);

  Future<Either<int, String>> getQuantityOfItemInCart(String modelId) async {
    try {
       final snapshot = await cartCollection.doc(modelId).get() ;
        if(snapshot.exists){
          return left(snapshot.data()![CartModelConstants.quantity]);
        }else{
          return left(0);
        }
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
  Future<Either<void, String>>quantityUpdate(bool isIncrement , String itemID)async{
    try{
      await cartCollection.doc(itemID).update({CartModelConstants.quantity : FieldValue.increment(isIncrement ? 1 : -1)}) ;
return left(null) ;
    }catch(e){

      return right(e.firebaseErrorMessage) ;
    }
  }
  Future<Either<void, String>> addItemToCart({required CartModel cartModel}) async {
    try {
      await cartCollection
          .doc(cartModel.itemID)
          .set(cartModel.toJson());
      return left(null);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
  Future<Either<void, String>> removeItemFromCart({required String itemID}) async {
    try {
      await cartCollection
          .doc(itemID)
          .delete();
      return left(null);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
  Future<Either<List<CartModel> , String>> getCartItems()  async{
    List<CartModel> cartItems = [] ;
    try{
      final response  = await cartCollection.orderBy(CartModelConstants.cartAddedDate).get() ;
      for(var item in response.docs){
        cartItems.add(CartModel.fromJson(item.data())) ;
      }
      return left(cartItems) ;

    }catch(e){
      return right(e.firebaseErrorMessage) ;
    }



  }
}
