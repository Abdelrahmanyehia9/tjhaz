import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/feature/favorite/data/model/favorite_date_helper.dart';
import 'package:tjhaz/feature/favorite/data/model/favorite_model.dart';

class FavoriteRepository {
  final FirebaseFirestore firestore;

  const FavoriteRepository(this.firestore);


  Future<void> addToFavorites({required String itemID}) async {
    final item = await firestore.collection(
        FireStoreConstants.userCollection).doc(SharedPrefHelper.getString(SharedPrefConstants.currentUserId)).collection(
        FireStoreConstants.favoriteCollection).doc(itemID).get();
    if (!item.exists) {
      item.reference.set(FavoriteModel(Timestamp.now()).toJson()).timeout(
          Duration(seconds: 10));
    }else{
      item.reference.delete().timeout(Duration(seconds: 10));
    }
  }
  Future<Either<List<EntertainmentDetailsModel>, String>> getAllFavorites() async {
    try {
      List<String> ids = await FavoriteDataHelper.instance.getFavoritesIdsInFirestore(firestore) ;
       List<EntertainmentDetailsModel> favorites = await FavoriteDataHelper.instance.fetchFavoritesDate(ids, firestore) ;
      return Left(favorites);
    } catch (e) {
      return Right(e.firebaseErrorMessage);
    }
  }
}