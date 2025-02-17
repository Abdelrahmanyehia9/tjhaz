class FirebaseAuthErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-disabled':
        return "Account has been blocked. Try another account.";
      case 'invalid-credential':
        return "Wrong password, try again later.";
      case 'too-many-requests':
        return "Too many requests, please try again later.";
      case 'network-request-failed':
        return "Network error, check your connection.";
      case 'email-already-in-use':
        return "This email is already in use. Try logging in.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'weak-password':
        return "The password provided is too weak.";
      default:
        return "Unexpected error: $errorCode";
    }
  }
}
