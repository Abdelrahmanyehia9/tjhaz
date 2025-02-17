import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_states.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordStates>{

  ResetPasswordCubit():super(ResetPasswordStatesInitial()) ;




  TextEditingController emailController = TextEditingController() ;
  TextEditingController otpController = TextEditingController() ;
  TextEditingController newPasswordController = TextEditingController() ;
  TextEditingController newPasswordConfirmController = TextEditingController() ;


  GlobalKey<FormState>resetPasswordKey = GlobalKey<FormState>() ;
  GlobalKey<FormState>newPasswordKey = GlobalKey<FormState>() ;


}