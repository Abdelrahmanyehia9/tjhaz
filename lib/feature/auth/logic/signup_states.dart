
abstract class SignupStates {
  const SignupStates();


}
class SignupStateInitial extends SignupStates{}
class SignupStateSuccess extends SignupStates{}
class SignupStateFailure extends SignupStates{
  final String errorMsg ;
  const SignupStateFailure({required this.errorMsg});

}