import 'package:flutter/material.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

class FacilitiesHelper {
  static String bedroom = "bedroom" ;
  static String bathroom = "bathroom" ;
  static String captain = "captin" ;
  static String guests = "guests" ;
  static String halls = "halls" ;
  static String area = "area" ;
  static IconData getIcon(String tittle) {
    switch (tittle) {
      case 'Microwave':
        return Icons.microwave_outlined;
      case 'AC':
        return Icons.ac_unit;
      case 'TV':
        return Icons.tv_outlined;
      case 'BBQ':
        return Icons.outdoor_grill_outlined;
      case "Coffee Machine":
        return Icons.coffee_outlined;
      case "Tan":
        return Icons.wb_sunny_outlined;
      case 'Sound System':
        return Icons.music_note_outlined;
        case 'Life Jacket':
        return Icons.dangerous;
      default:
        return Icons.ac_unit;
    }
  }
}
