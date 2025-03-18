import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/logic/logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates>{
final LoginRepo loginRepo ;

  LogoutCubit(this.loginRepo) :super (LogoutStatesInitial());


  Future<void> logout()async{
    try{
      safeEmit(LogoutStatesLoading()) ;
      await loginRepo.logout() ;
      Future.delayed(Duration(seconds: 2) , (){
        safeEmit(LogoutStatesSuccess()) ;
      }) ;
    }catch(e){
      safeEmit(LogoutStatesFailure(errorMsg: e.firebaseErrorMessage)) ;
    }

  }


}