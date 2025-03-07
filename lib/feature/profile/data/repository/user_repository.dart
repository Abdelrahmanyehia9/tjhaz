import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/database/remote/firestore_errorHandler.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/auth/data/repository/auth_repo.dart';

import '../../../../core/database/remote/fireStore_constants.dart';
import '../../../auth/data/repository/user_data_helper.dart';
import '../../../auth/data/models/user_model.dart';

class UserRepository{

  final FirebaseFirestore firestore  ;
  UserRepository({required this.firestore});
  Future<Either<DocumentReference<Map<String, dynamic>>, String>>addNewUser({required UserModel userModel})async {
    try {
      DocumentReference<Map<String, dynamic>> user = await firestore.collection(
          FireStoreConstants.userCollection).add(userModel.toJson());
      return left(user);
    } catch (e) {
      return right(e.firebaseErrorMessage);
    }
  }
  Future<Either<UserModel, String>> getUserInfo({required String userID }) async {
    final localUser = UserDataHelper.getLocalUser(userID );
    if (localUser != null) return left(localUser);
    return await UserDataHelper.fetchUserFromFirestore(userID , firestore);
  }

  Future<Either<UserModel, String>>editUserInfo({required UserModel userModel})async{
try{
  final response = await firestore.collection(FireStoreConstants.userCollection).where("userID",isEqualTo: userModel.uID).get();
   await response.docs.first.reference.update(userModel.toJson()).timeout(Duration(seconds: 10)) ;
   await UserDataHelper.saveUserToLocal(userModel) ;
   return left(userModel) ;
}catch(e){
  return right(e.firebaseErrorMessage) ;
  }
  }
}