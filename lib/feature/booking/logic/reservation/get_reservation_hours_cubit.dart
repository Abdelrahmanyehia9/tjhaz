import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_states.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';

class GetReservedHoursCubit extends Cubit<GetReservedHoursStates> {

  final BookingRepository bookingRepository;
  int currentDay = DateTime.now().day ;
  List<int>reservedHours = []  ;
  int? startingHoursSelectedIndex ;
  int selectedDurationIndex = 0  ;

  GetReservedHoursCubit(this.bookingRepository)
      : super(GetReservedHoursInitial());

  Future<void> getReservedHours({required EntertainmentDetailsModel model, required String month , required int duration }) async {
    startingHoursSelectedIndex = null ;
    emit(GetReservedHoursLoading());

    final results = await bookingRepository.getReservedHoursByEnterID(
      month: month.toLowerCase(),
      entertainmentID: model.id,
      day: currentDay ,
    );

    results.fold(
          (reservedHours) {
            this.reservedHours = reservedHours??[] ;
            this.reservedHours = getAvailableHoursByDuration(model, duration);
        emit(GetReservedHoursSuccess());
      },
          (error) {
        emit(GetReservedHoursFailure(error));
      },
    );
  }
   void reset(){
    currentDay = DateTime.now().day ;
    reservedHours = []  ;
    startingHoursSelectedIndex = null ;
    selectedDurationIndex = 0  ;
    safeEmit(GetReservedHoursInitial()) ;
}

  List<int> getAvailableHoursByDuration(EntertainmentDetailsModel  model ,int duration ) {
    List<int> availableHours = [];
    for (int startHour = model.availableFrom; startHour <= model.availableTo - duration ; startHour++) {
      bool canFit = true;

      for (int i = 0; i < duration; i++) {
        if (reservedHours.contains(startHour + i)) {
          canFit = false;
          break;
        }
      }
      if (canFit) {
        availableHours.add(startHour);
      }
    }
    return availableHours;
  }

}
