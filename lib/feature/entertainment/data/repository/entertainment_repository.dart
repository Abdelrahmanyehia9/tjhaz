import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/fireStore_constants.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/core/extention/firestore_error_message.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';

class EntertainmentRepository {
  final FirebaseFirestore firestore;

  EntertainmentRepository({required this.firestore});

  Future<Either<EntertainmentDetailsModel, String>> getEntertainmentDetailsByID(
      {required String entertainmentID }) async {
    try {
      final result = await firestore.collection("entertainment").doc(
          entertainmentID).get();
      EntertainmentDetailsModel entertainment = EntertainmentDetailsModel
          .fromJson(result.data()!);
      return left(entertainment);
    } catch (e) {
      return right(e.firestoreErrorMessage);
    }
  }

  Future<Either<List<EntertainmentDetailsModel>,
      String>> getEntertainmentsByCategoryID({required String catID}) async {
    try {
      List<EntertainmentDetailsModel> entertainments = [];
      final response = await firestore.collection(
          FireStoreConstants.entertainment).where(
          "category_id", isEqualTo: catID).get();
      for (var item in response.docs) {
        entertainments.add(EntertainmentDetailsModel.fromJson(item.data()));
      }
      return left(entertainments);
    } catch (e) {
      return right(e.firestoreErrorMessage)  ;
    }
  }


}