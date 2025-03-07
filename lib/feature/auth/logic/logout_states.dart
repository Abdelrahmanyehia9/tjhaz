abstract class LogoutStates {}

class LogoutStatesInitial extends LogoutStates {}

class LogoutStatesLoading extends LogoutStates {}

class LogoutStatesSuccess extends LogoutStates {}

class LogoutStatesFailure extends LogoutStates {
  final String errorMsg;
  LogoutStatesFailure({required this.errorMsg});
}
