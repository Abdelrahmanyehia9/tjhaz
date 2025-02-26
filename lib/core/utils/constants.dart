import 'package:tjhaz/core/utils/app_localization.dart';
import 'package:tjhaz/main.dart';

class AppConstants {
  static const String appLogo = "assets/images/logo.png";
  static const String splashLogo = "assets/images/splash.png";
  static const String catActivities = "assets/icons/activities.svg";
  static const String catTrips = "assets/icons/trips.svg";
  static const String catWild = "assets/icons/cashta.svg";
  static const String catShopping = "assets/icons/shopping.svg";
  static const String empty = "assets/images/empty-box (1).svg" ;
  static const String disconnected ="assets/images/disconnected.svg" ;
  static const String error ="assets/images/error.svg" ;
  static String currentLanguage = currentLocale.languageCode.toUpperCase();
  static List<Map<String, String>> categories = [
    {
      "image": catTrips,
      "title": AppLocalizationsString.trips,
      "id": "1"
    },
    {"image": catWild, "title": AppLocalizationsString.wild, "id": "2"},
    {"image": catActivities, "title": AppLocalizationsString.activities, "id": "3"},
    {"image": catShopping, "title": AppLocalizationsString.shopping, "id": "shopping"}
  ];
}
