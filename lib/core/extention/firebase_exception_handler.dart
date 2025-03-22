import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../database/remote/auth_error_handler.dart';
import '../database/remote/firestore_error_handler.dart';

extension FirebaseExceptionHandler on Object {
  String get firebaseErrorMessage {

    switch (this) {
      case FirebaseAuthException e:
        return FirebaseAuthErrorHandler.getErrorMessage(e.code);
      case FirebaseException e:
        return FirestoreErrorHandler.getErrorMessage(e.code);

      case TimeoutException _:
        return "⏳ Request timed out. Please check your network and try again.";

      case FormatException _:
        return "⚠️ Data format error. Please contact support.";

      case SocketException _:
      case HttpException _:
        return "📡 No Internet Connection. Please connect to a network and try again.";

      case _:
        return "❌ Unexpected error: ${toString()}";
    }



  }
}
