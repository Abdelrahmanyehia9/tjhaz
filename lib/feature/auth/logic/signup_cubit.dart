import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/auth/logic/login_states.dart';

class SignupCubit extends Cubit{
  SignupCubit():super(LoginStateInitial())  ;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();
  final formKey = GlobalKey<FormState>();





}