import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/auth/data/repository/auth_repo.dart';


class LoginRepo extends AuthRepository{

  final FirebaseAuth firebaseAuth ;
  LoginRepo({required this.firebaseAuth});
  Future<Either<UserCredential , String>>loginUsingEmailAndPassword({required String email  , required String password})async{

    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password) ;
      return left(userCredential) ;
    }catch(e){
      return right(e.firebaseErrorMessage) ;
    }






  }
  Future<Either<UserCredential, String>> loginAnonymous() async {
    try {
      UserCredential credential = await firebaseAuth.signInAnonymously()
          .timeout(Duration(seconds: 10)); // Timeout after 10 seconds

      return left(credential); // Success case
    } catch(e){
      return right (e.firebaseErrorMessage) ;
    }
  }
  Future<void>logout()async{
    await firebaseAuth.signOut() ;
    await SharedPrefHelper.removeKey(SharedPrefConstants.currentUserEmail) ;
    await SharedPrefHelper.removeKey(SharedPrefConstants.currentUserId) ;
    await SharedPrefHelper.removeKey(SharedPrefConstants.currentUserBirthDate) ;
    await SharedPrefHelper.removeKey(SharedPrefConstants.currentUserName) ;
  }
}