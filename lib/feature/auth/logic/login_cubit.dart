import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
 final LoginRepo loginRepo  ;
 LoginCubit(this.loginRepo):super(LoginStateInitial())  ;
  Future<void>login({required String email  , required String password})async{
  final result = await loginRepo.loginUsingEmailAndPassword(email: email, password: password);
   _handleLoginResult(result) ;
  }
  Future<void>loginAnonymous()async{
    final result = await loginRepo.loginAnonymous() ;
   _handleLoginResult(result) ;

  }


 Future<void> _handleLoginResult(Either<UserCredential, String> result) async {
  result.fold(
          (credential) async {
       if (credential.user != null) {
        await loginRepo.saveUserData(credential.user!);
        safeEmit(LoginStateSuccess());
       } else {
        safeEmit(const LoginStateFailure(errorMsg: "User authentication failed."));
       }
      },
  (error) {
   safeEmit(LoginStateFailure(errorMsg: error));
  });
 }
}