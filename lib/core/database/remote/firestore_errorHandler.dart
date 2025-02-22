class FirestoreErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'permission-denied':
        return "You don't have permission to access this data.";
      case 'unavailable':
        return "Firestore service is currently unavailable. Try again later.";
      case 'not-found':
        return "Requested document was not found.";
      case 'already-exists':
        return "This document already exists.";
      case 'deadline-exceeded':
        return "Operation took too long to complete. Try again later.";
      case 'resource-exhausted':
        return "Quota exceeded. Try again later.";
      case 'cancelled':
        return "Operation was cancelled.";
      case 'data-loss':
        return "Data loss occurred. Please contact support.";
      case 'invalid-argument':
        return "Invalid data provided.";
      case 'internal':
        return "Internal Firestore error. Try again later.";
      case 'aborted':
        return "Operation was aborted due to concurrency issues.";
      case 'failed-precondition':
        return "Operation cannot be executed in the current system state.";
      default:
        return "Something went wrong. Please try again.";
    }
  }
}
