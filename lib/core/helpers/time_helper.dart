import '../utils/app_strings.dart';

class TimeHelper{
   const TimeHelper._();



  static String convertTime(int time){
    if (time >= 12) {
      int hour = (time > 12) ? time - 12 : 12;
      return "${hour.toString().padLeft(2, '0')}:00 ${AppStrings.pm}";
    } else {
      int hour = (time == 0) ? 12 : time;
      return "${hour.toString().padLeft(2, '0')}:00 ${AppStrings.am}";
    }
  }









}