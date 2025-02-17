abstract class SignupStates {}
class SignupStateInitial extends SignupStates{}
class SignupStateLoading extends SignupStates{}

class SignupStateSuccess extends SignupStates{}
class SignupStateFailure extends SignupStates{
  final String errorMsg ;
  SignupStateFailure({required this.errorMsg});
}