import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/database/remote/auth_error_handler.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
 final LoginRepo loginRepo  ;
 LoginCubit(this.loginRepo):super(LoginStateInitial())  ;
  Future<void>login({required String email  , required String password})async{
   emit(LoginStateLoading()) ;
  final result = await loginRepo.loginUsingEmailAndPassword(email: email, password: password);
  result.fold((credential){
   emit(LoginStateSuccess()) ;
  }, (error){
   emit(LoginStateFailure(errorMsg: error)) ;
  }) ;
  }
}