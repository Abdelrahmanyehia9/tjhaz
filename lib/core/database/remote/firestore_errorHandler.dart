import 'package:tjhaz/core/utils/app_strings.dart';

class FirestoreErrorHandler {
  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'permission-denied':
        return AppStrings.fireStoreExPermissionDenied;
      case 'unavailable':
        return AppStrings.fireStoreExeUnAvailable;
      case 'not-found':
        return AppStrings.fireStoreExNotFound;
      case 'already-exists':
        return AppStrings.fireStoreExAlreadyExists;
      case 'deadline-exceeded':
        return AppStrings.fireStoreExDeadlineExceeded;
      case 'resource-exhausted':
        return AppStrings.fireStoreExResourceExhausted;
      case 'cancelled':
        return AppStrings.fireStoreExCancelled;
      case 'data-loss':
        return AppStrings.fireStoreExDataLoss;
      case 'invalid-argument':
        return AppStrings.fireStoreExInvalidArgument;
      case 'internal':
        return AppStrings.fireStoreExInternal;
      case 'aborted':
        return AppStrings.fireStoreExAborted;
      case 'failed-precondition':
        return AppStrings.fireStoreExFailedPrecondition;
      case "timeout":
        return "time Out";
      default:
        return AppStrings.genericError;
    }
  }
}
