import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/database/remote/auth_error_handler.dart';

class LoginRepo{

  final FirebaseAuth firebaseAuth ;
  LoginRepo({required this.firebaseAuth});


  Future<Either<UserCredential , String>>loginUsingEmailAndPassword({required String email  , required String password})async{

    try{
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password) ;
      return left(userCredential) ;
    }catch(e){
      if(e is FirebaseAuthException){
        return right(FirebaseAuthErrorHandler.getErrorMessage(e.code)) ;
      }else{
        return right(FirebaseAuthErrorHandler.getErrorMessage(e.toString())) ;
      }
    }






  }
   bool isLoggedUser(){
   return   firebaseAuth.currentUser != null ;
}



}