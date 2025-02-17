import 'package:tjhaz/core/helpers/app_regex.dart';

class AppValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password shouldn't be empty";
    }
    return null;
  }
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username shouldn't be empty";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email shouldn't be empty";
    } else if (!AppRegex.isEmailValid(value)) {
      return "Please enter a valid email";
    }
    return null;
  }
}
