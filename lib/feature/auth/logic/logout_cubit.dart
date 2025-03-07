import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/logic/logout_states.dart';

class LogoutCubit extends Cubit<LogoutStates>{
final LoginRepo loginRepo ;

  LogoutCubit(this.loginRepo) :super (LogoutStatesInitial());


  Future<void> logout()async{
    try{
      emit(LogoutStatesLoading()) ;
      await loginRepo.logout() ;
      Future.delayed(Duration(seconds: 2) , (){
        emit(LogoutStatesSuccess()) ;
      }) ;
    }catch(e){
      emit(LogoutStatesFailure(errorMsg: e.firebaseErrorMessage)) ;
    }

  }


}