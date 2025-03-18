import 'dart:ui';

import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/utils/app_assets.dart';

import '../../main.dart';
import 'app_strings.dart';

class AppConstants{

const AppConstants._();


  static String currentLanguage = currentLocale.toUpperCase();
  static String currentLocale = SharedPrefHelper.getString(SharedPrefConstants.currentLanguage) ?? "ar";
  static List<Map<String, String>> categories = [
    {
      "image": AppAssets.catTrips,
      "title": AppStrings.trips,
      "id": "1"
    },
    {"image": AppAssets.catWild, "title": AppStrings.wild, "id": "2"},
    {"image": AppAssets.catActivities, "title": AppStrings.activities, "id": "3"},
    {"image": AppAssets.catShopping, "title": AppStrings.stores, "id": "shopping"}
  ];




}