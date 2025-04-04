import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/database/remote/auth_error_handler.dart';
import 'package:tjhaz/core/database/remote/firestore_constants.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/auth/data/models/user_model.dart';
import 'package:tjhaz/feature/auth/data/repository/sign_up_repository.dart';
import 'package:tjhaz/feature/auth/logic/signup_states.dart';

import '../../../core/database/local/shared_prefrences_constants.dart';

class SignupCubit extends Cubit<SignupStates> {
  final SignUpRepository signUpRepository;

  SignupCubit(this.signUpRepository) : super(SignupStateInitial());
  Future<void> signUpByEmailAndPassword({required String username, required String email, required String password}) async
  {
     safeEmit(SignupStateLoading()) ;
    final result = await signUpRepository.signUpUsingEmailAndPassword(
        username: username, email: email, password: password);
    result.fold((user) async{
      signUpRepository.saveUserData(user.user!) ;
      await SharedPrefHelper.setString(SharedPrefConstants.currentUserName, username );
      safeEmit(SignupStateSuccess());
    }, (error) {
      safeEmit(SignupStateFailure(errorMsg: error));
    });
  }



}
