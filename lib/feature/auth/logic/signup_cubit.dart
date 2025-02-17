import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/networking/auth_error_handler.dart';
import 'package:tjhaz/core/networking/fireStore_constants.dart';
import 'package:tjhaz/feature/auth/data/models/user_model.dart';
import 'package:tjhaz/feature/auth/logic/signup_states.dart';

class SignupCubit extends Cubit<SignupStates>{

  final FirebaseAuth firebaseAuth  ;
  final FirebaseFirestore fireStore  ;
  SignupCubit(this.firebaseAuth , this.fireStore):super(SignupStateInitial())  ;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

Future<void>signUpByEmailAndPassword({required String username  , required String email , required String password})async{
  emit(SignupStateLoading()) ;
  try{
  UserCredential credential = await  firebaseAuth.createUserWithEmailAndPassword(email: email, password: password) ;
  UserModel userModel = UserModel(uID: credential.user!.uid, username: username, emailAddress:email) ;
 await fireStore.collection(FireStoreConstants.userCollection).add(userModel.toJson());
 emit(SignupStateSuccess());
  }catch(e){
    final String error ;
    if(e is FirebaseAuthException){
      error = FirebaseAuthErrorHandler.getErrorMessage(e.code) ;
    }else{

      error = FirebaseAuthErrorHandler.getErrorMessage(e.toString()) ;
    }
    emit(SignupStateFailure(errorMsg: error)) ;

  }






}



}