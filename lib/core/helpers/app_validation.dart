import 'package:tjhaz/core/helpers/app_regex.dart';
import 'package:tjhaz/core/utils/app_localization.dart';

class AppValidators {
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppLocalizationsString.password} ${AppLocalizationsString.shouldNotBeEmpty}";
    }
    return null;
  }
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppLocalizationsString.username} ${AppLocalizationsString.shouldNotBeEmpty}";
    }
    return null;
  }
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "${AppLocalizationsString.email} ${AppLocalizationsString.shouldNotBeEmpty}";
    } else if (!AppRegex.isEmailValid(value)) {
      return AppLocalizationsString.pleaseEnterValidEmail;
    }
    return null;
  }
}
