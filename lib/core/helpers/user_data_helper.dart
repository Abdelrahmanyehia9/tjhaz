import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import '../../feature/auth/data/models/user_model.dart';
import '../database/local/shared_prefrences_constants.dart';
import '../database/remote/fireStore_constants.dart';

class UserDataHelper {

  static UserModel? getLocalUser(String userID) {
    final username = SharedPrefHelper.getString(SharedPrefConstants.currentUserName);
    final email = SharedPrefHelper.getString(SharedPrefConstants.currentUserEmail);
    final birthDate = SharedPrefHelper.getString(SharedPrefConstants.currentUserBirthDate);

    if (username != null && email != null && birthDate != null) {
      return UserModel(uID: userID, username: username, emailAddress: email, birthDate: birthDate);
    }
    return null;
  }

  static Future<void> saveUserToLocal(UserModel user) async {
    await Future.wait([
      SharedPrefHelper.setString(SharedPrefConstants.currentUserName, user.username),
      SharedPrefHelper.setString(SharedPrefConstants.currentUserEmail, user.emailAddress),
      SharedPrefHelper.setString(SharedPrefConstants.currentUserBirthDate, user.birthDate ?? "NO birthdate provided"),
    ]);
  }

  static Future<Either<UserModel, String>> fetchUserFromFirestore(String userID , FirebaseFirestore firestore ) async {
    try {
      final snapshot = await firestore.collection(FireStoreConstants.userCollection).where("userID" , isEqualTo: userID).get();
      if (snapshot.docs.isEmpty) return right("User not found");
      final userModel = UserModel.fromJson(snapshot.docs.first.data());
      await saveUserToLocal(userModel);
      return left(userModel);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
}
