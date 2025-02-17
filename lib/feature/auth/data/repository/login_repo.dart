import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/feature/auth/data/repository/auth_repo.dart';

class LoginRepository extends AuthRepository {
  LoginRepository({required super.auth});

  Future<UserCredential?> loginByEmailAndPassword(String email, String password) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      // Log the error or handle specific FirebaseAuth errors
      print("Login failed: ${e.message}");
      return null; // Return null instead of nothing
    } catch (e) {
      // Handle other unexpected errors
      print("Unexpected error: $e");
      return null;
    }
  }
}
