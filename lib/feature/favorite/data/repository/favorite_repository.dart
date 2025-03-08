import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/feature/favorite/data/model/favorite_model.dart';

class FavoriteRepository {
  final FirebaseFirestore firestore;

  FavoriteRepository(this.firestore);

  Future<Either<List<FavoriteModel>, String>> getAllFavorites() async {
    try {
      List<FavoriteModel> allFavorites = [];
      final response = await firestore.collection(
          FireStoreConstants.userCollection).where(
          "userID", isEqualTo: AppConstants.currentUserID).get().timeout(Duration(seconds: 10));
      final QuerySnapshot<
          Map<String, dynamic>> favoriteResponse = await response.docs.first
          .reference.collection(FireStoreConstants.favoriteCollection).orderBy("addedDate" , descending: false)
          .get()
          .timeout(Duration(seconds: 10));
      for (var element in favoriteResponse.docs) {
        allFavorites.add(FavoriteModel.fromJson(element.data()));
      }
      return left(allFavorites);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<void> addToFavorites({required FavoriteModel favoriteModel}) async {
   final response  = await firestore.collection(FireStoreConstants.userCollection).where("userID" , isEqualTo: AppConstants.currentUserID).get().timeout(Duration(seconds: 10)) ;
   await response.docs.first.reference.collection(FireStoreConstants.favoriteCollection).add(favoriteModel.toJson()).timeout(Duration(seconds: 10)) ;
  }
}
