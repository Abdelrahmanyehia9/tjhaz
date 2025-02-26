import 'package:equatable/equatable.dart';

abstract class LoginStates {
  const LoginStates();

}
class LoginStateInitial extends LoginStates{}
class LoginStateSuccess extends LoginStates{}
class LoginStateFailure extends LoginStates{
  final String errorMsg ;
  const LoginStateFailure({required this.errorMsg});

}
