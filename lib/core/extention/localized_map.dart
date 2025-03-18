import 'package:tjhaz/core/utils/app_constants.dart';
import 'package:tjhaz/core/utils/app_strings.dart';


extension LocalizedMap on Map<String, dynamic>? {
  String get localized {
    final value = this?[AppConstants.currentLanguage] ?? this?['EN'];
    return value is String ? value : AppStrings.notSpecified;
  }

  String localizedWith(String currentLanguage, {String defaultLanguage = 'EN'}) {
    if (this == null) return '';
    final value = this![currentLanguage] ?? this![defaultLanguage];
    return value is String ? value : '';
  }
}
