import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';

import 'package:tjhaz/core/routes/index.dart';

import '../../../../core/database/remote/firestore_constants.dart';
import '../../../../core/utils/app_constants.dart';

class FavoriteDataHelper {

  const FavoriteDataHelper._();
  static final FavoriteDataHelper instance = FavoriteDataHelper._();
  Future<List<String>> getFavoritesIdsInFirestore(FirebaseFirestore firestore) async {
    final favoriteResponse = await firestore
        .collection(FireStoreConstants.userCollection)
.doc(SharedPrefHelper.getString(SharedPrefConstants.currentUserId))
        .collection(FireStoreConstants.favoriteCollection)
        .orderBy("addedDate")
        .get()
        .timeout(Duration(seconds: 10));


    List<String>ids = [];

    for (var favorite in favoriteResponse.docs) {
      String itemID = favorite.id;
      ids.add(itemID);
    }
    return ids;
  }
  Future <List<EntertainmentDetailsModel>> fetchFavoritesEntertainments(List<String> favIds , FirebaseFirestore firestore) async {


    List<EntertainmentDetailsModel> favorites = [];

    for (var favorite in favIds) {

      final entertainmentResponse = await firestore
          .collection(FireStoreConstants.entertainment)
          .where("id", isEqualTo: favorite)
          .get()
          .timeout(Duration(seconds: 10));

      if (entertainmentResponse.docs.isNotEmpty) {
        final entertainmentData = entertainmentResponse.docs.first.data();
        favorites.add(EntertainmentDetailsModel.fromJson(entertainmentData));
      }
    }

    return favorites;
  }
  Future <List<ProductModel>> fetchFavoriteProducts(List<String> favIds , FirebaseFirestore firestore) async {


    List<ProductModel> favorites = [];

    for (var favorite in favIds) {

      final productsResponse = await firestore
          .collection(FireStoreConstants.productCollection)
          .where("id", isEqualTo: favorite)
          .get()
          .timeout(Duration(seconds: 10));

      if (productsResponse.docs.isNotEmpty) {
        final productsData = productsResponse.docs.first.data();
        favorites.add(ProductModel.fromJson(productsData));
      }
    }

    return favorites;
  }


}