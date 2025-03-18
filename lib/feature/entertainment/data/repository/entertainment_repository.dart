import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/extention/firebase_caching_helper.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model_constants.dart';

class EntertainmentRepository {
  final FirebaseFirestore firestore;

  EntertainmentRepository({required this.firestore});

  Future<Either<EntertainmentDetailsModel, String>> getEntertainmentDetailsByID({
    required String entertainmentID,
  }) async {
    try {
      final result = await firestore.getDocumentWithCache(
          FireStoreConstants.entertainment, entertainmentID);

      if (!result.exists || result.data() == null) {
        return right("Entertainment details not found.");
      }

      return left(EntertainmentDetailsModel.fromJson(result.data()!));
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }

  Future<Either<List<EntertainmentDetailsModel>, String>> getEntertainmentsByCategoryID({
    required String catID,
  }) async {
    try {
      List<EntertainmentDetailsModel> entertainments = [];

      final response = await firestore.getCollectionWithWhereCache(
        FireStoreConstants.entertainment,
        EntertainmentDetailsModelConstants.categoryID,
        catID,
      );

      for (var item in response.docs) {
        entertainments.add(EntertainmentDetailsModel.fromJson(item.data()));
      }

      return left(entertainments);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
}
