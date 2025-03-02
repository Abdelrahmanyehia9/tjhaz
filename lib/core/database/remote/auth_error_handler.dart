import '../../utils/app_strings.dart';

class FirebaseAuthErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-disabled':
        return AppStrings.userDisabled;
      case 'invalid-credential':
        return AppStrings.invalidCredential;
      case 'too-many-requests':
        return AppStrings.tooManyRequests;
      case 'network-request-failed':
        return AppStrings.networkRequestFailed;
      case 'email-already-in-use':
        return AppStrings.emailAlreadyInUse;
      case 'user-not-found':
        return AppStrings.userNotFound;
      case 'weak-password':
        return AppStrings.weakPassword;
      default:
        return AppStrings.genericError;
    }
  }
}
