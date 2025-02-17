import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/networking/auth_error_handler.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{

 LoginCubit(this.firebaseAuth):super(LoginStateInitial())  ;
 final FirebaseAuth firebaseAuth ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
Future<void>login(email, password)async{
 emit(LoginStateLoading()) ;
 try{
  await firebaseAuth.signInWithEmailAndPassword(email: email, password: password) ;
  emit(LoginStateSuccess()) ;
 }
 catch(e){
  final String error ;
  if(e is FirebaseAuthException){
   error = FirebaseAuthErrorHandler.getErrorMessage(e.code) ;
  }else{
   error = FirebaseAuthErrorHandler.getErrorMessage(e.toString()) ;
  }
  emit(LoginStateFailure(errorMsg: error)) ;
 }
}
}