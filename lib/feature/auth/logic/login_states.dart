abstract class LoginStates {}
class LoginStateInitial extends LoginStates{}
class LoginStateLoading extends LoginStates{}
class LoginStateSuccess extends LoginStates{}
class LoginStateFailure extends LoginStates{
  final String errorMsg ;
  LoginStateFailure({required this.errorMsg});
}
