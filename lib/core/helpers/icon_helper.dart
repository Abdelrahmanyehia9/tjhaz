
import 'package:flutter/material.dart';

import '../styles/app_icon.dart';


class IconHelper {
  static const Map<String, IconData> _icons = {

    "Kashta": AppIcons.kashta,
    "Caravans": AppIcons.caravan,
    "Camps": AppIcons.camp,
    "Boat": AppIcons.boat,
    "Island": AppIcons.island,
    "Diving": AppIcons.diving,
    "Yacht": AppIcons.yacht,
    "Fishing": AppIcons.fishing,
    "Coffee Machine": AppIcons.coffeeMachine,
    "Fridge": AppIcons.fridge,
    "Wifi": AppIcons.wifi,
    "GPS Navigation": AppIcons.gpsNavigation,
    "Sound System": AppIcons.soundSystem,
    "Shower": AppIcons.shower,
    "Life Jacket": AppIcons.lifeJacket,
    "Swimming Ladder": AppIcons.swimmingLadder,
    "Jet Ski": AppIcons.jetSki,
    "Ice Box": AppIcons.iceBox,
    "Fishing Tools": AppIcons.fishingTools,
    "First Aid Kit": AppIcons.firstAidKit,
    "Cabins": AppIcons.cabins,
    "Snorkeling Gear": AppIcons.snorkelingGear,
    "AC": AppIcons.ac,
    "TV": AppIcons.tv,
    "BBQ Grill": AppIcons.bbqGrill,
    "Tan": AppIcons.tan,
    "Microwave": AppIcons.microwave,
  };

  static IconData getFacilitiesIcon(String iconName) {
    return _icons[iconName]?? Icons.play_circle_outline;
  }
  static IconData getCategoriesIcon(String iconName) {
    return _icons[iconName]?? Icons.broken_image_outlined;
  }

}
