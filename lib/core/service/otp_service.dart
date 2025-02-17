import 'package:firebase_auth/firebase_auth.dart';


class OTPService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  Future<void> sendOtp(String phoneNumber, Function(String) onCodeSent) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          _handleVerificationError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  Future<void> verifyOtp(String otp) async {
    if (_verificationId == null) {
      print("No verification ID found. Request OTP first.");
      return;
    }
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _signInWithCredential(credential);
    } catch (e) {
      print("Error verifying OTP: $e");
    }
  }

  Future<void> _signInWithCredential(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("User logged in: ${userCredential.user?.uid}");
    } catch (e) {
      print("Error signing in: $e");
    }
  }

  void _handleVerificationError(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      print("The provided phone number is not valid.");
    } else {
      print("Verification failed: ${e.message}");
    }
  }
}
