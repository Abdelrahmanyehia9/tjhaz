import 'package:tjhaz/core/helpers/app_regex.dart';
import 'package:tjhaz/core/utils/app_strings.dart';

class AppValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppStrings.password} ${AppStrings.shouldNotBeEmpty}";
    }
    return null;
  }
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppStrings.username} ${AppStrings.shouldNotBeEmpty}";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppStrings.email} ${AppStrings.shouldNotBeEmpty}";
    } else if (!AppRegex.isEmailValid(value)) {
      return AppStrings.pleaseEnterValidEmail;
    }
    return null;
  }
}
