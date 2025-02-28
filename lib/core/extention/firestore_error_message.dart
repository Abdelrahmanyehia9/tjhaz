import 'package:cloud_firestore/cloud_firestore.dart';

import '../database/remote/firestore_errorHandler.dart';

extension FirestoreExceptionHandler on Object {
  String get firestoreErrorMessage {
    if (this is FirebaseException) {
      return FirestoreErrorHandler.getErrorMessage((this as FirebaseException).code);
    } else {
      return FirestoreErrorHandler.getErrorMessage(toString());
    }
  }
}
