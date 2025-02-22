import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../auth/data/models/user_model.dart';

class UserRepository{

  final FirebaseFirestore firestore  ;
  UserRepository({required this.firestore});
  Future<Either<DocumentReference<Map<String, dynamic>>, String>>addNewUser({required UserModel userModel})async {
    try {
      DocumentReference<Map<String, dynamic>> user = await firestore.collection(
          FireStoreConstants.userCollection).add(userModel.toJson());
      return left(user);
    } on FirebaseException catch (e) {
      return right(FirestoreErrorHandler.getErrorMessage(e.code));
    } catch (e) {
      return right(FirestoreErrorHandler.getErrorMessage(e.toString()));
    }
  }


}