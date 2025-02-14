import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';

class LoginCubit extends Cubit{
 LoginCubit():super(LoginStateInitial())  ;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


}