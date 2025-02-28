import '../../utils/app_localization.dart';

class FirebaseAuthErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-disabled':
        return AppLocalizationsString.userDisabled;
      case 'invalid-credential':
        return AppLocalizationsString.invalidCredential;
      case 'too-many-requests':
        return AppLocalizationsString.tooManyRequests;
      case 'network-request-failed':
        return AppLocalizationsString.networkRequestFailed;
      case 'email-already-in-use':
        return AppLocalizationsString.emailAlreadyInUse;
      case 'user-not-found':
        return AppLocalizationsString.userNotFound;
      case 'weak-password':
        return AppLocalizationsString.weakPassword;
      default:
        return AppLocalizationsString.genericError;
    }
  }
}
