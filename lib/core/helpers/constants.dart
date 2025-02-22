import 'package:tjhaz/core/utils/app_localization.dart';

class AppConstants{
  static const String appLogo = "assets/images/logo.png" ;
static const String splashLogo = "assets/images/splash.png" ;
  static const String catActivities = "assets/icons/activities.svg" ;
  static const String catTrips = "assets/icons/trips.svg" ;
  static const String catKashta = "assets/icons/cashta.svg" ;
  static const String catShopping = "assets/icons/shopping.svg" ;
  static const String navCart = "assets/icons/Vector.svg" ;
  static const String navHome = "assets/icons/Vector (2).svg" ;
  static const String navBooking = "assets/icons/Vector (1).svg" ;
  static const String navCategories = "assets/icons/Vector (3).svg" ;
  static const String navProfile = "assets/icons/Group 9.svg" ;






  static  List<Map<String, String>> categories = [
    {
      "image": catTrips, // Change to your actual image path
      "title": AppLocalizations.trips,
    }, { "image": catKashta, "title": AppLocalizations.kashta}, {
      "image": catActivities,
      "title": AppLocalizations.activities,
    } , {
      "image": catShopping,
      "title": AppLocalizations.shopping,
    }

  ];







}