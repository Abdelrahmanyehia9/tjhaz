import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tjhaz/core/routes/index.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../../core/utils/app_constants.dart';

class FavoriteDataHelper {

  const FavoriteDataHelper._();
  static final FavoriteDataHelper instance = FavoriteDataHelper._();
  Future<List<String>> getFavoritesIdsInFirestore(FirebaseFirestore firestore) async {
    final userResponse = await firestore
        .collection(FireStoreConstants.userCollection)
        .where("userID", isEqualTo: AppConstants.currentUserID)
        .get()
        .timeout(Duration(seconds: 10));


    final favoriteResponse = await userResponse.docs.first
        .reference
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
  Future <List<EntertainmentDetailsModel>> fetchFavoritesDate(List<String> favIds , FirebaseFirestore firestore) async {


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


}