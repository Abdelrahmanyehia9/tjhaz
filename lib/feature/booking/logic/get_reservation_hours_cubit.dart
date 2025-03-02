import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/get_reservation_hours_states.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';

class GetReservedHoursCubit extends Cubit<GetReservedHoursStates> {

  final BookingRepository bookingRepository;
  int currentDay = DateTime.now().day ;
  List<int> reservedHours = [] ;


  GetReservedHoursCubit(this.bookingRepository)
      : super(GetReservedHoursInitial());

  Future<void> getReservedHours({required String entertainmentID, required String month }) async {
    emit(GetReservedHoursLoading());

    final results = await bookingRepository.getReservedHoursByEnterID(
      month: month.toLowerCase(),
      entertainmentID: entertainmentID,
      day: currentDay ,

    );

    results.fold(
          (reservedHours) {
        emit(GetReservedHoursSuccess(reservedHours));
      },
          (error) {
        emit(GetReservedHoursFailure(error));
      },
    );
  }
  void getAvailableHoursByDuration(EntertainmentDetailsModel  model ,int duration) {
    safeEmit(GetReservedHoursLoading ()) ;
    List<int> availableHours = [];
    for (int startHour = model.availableFrom; startHour <= model.availableTo - duration + 1; startHour++) {
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
    safeEmit(GetReservedHoursSuccess(availableHours))  ;
  }
}
