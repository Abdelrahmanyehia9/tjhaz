import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/get_reservation_date_states.dart';

class GetReservedDatesCubit extends Cubit<GetReservedDatesStates> {

  final BookingRepository bookingRepository;
  String currentMonth =DateFormat('MMM').format(DateTime.now()).toLowerCase();
  GetReservedDatesCubit(this.bookingRepository)
      : super(GetReservedDatesInitial());

  Future<void> getReservedDays({
    required String entertainmentID,
  }) async {
    emit(ReservationDatesLoading());

    final results = await bookingRepository.getReservedDaysByEnterID(
      month: currentMonth,
      entertainmentID: entertainmentID,
    );

    results.fold(
          (reservedDates) {
        emit(GetReservedDateSuccess(reservedDates));
      },
          (error) {
        emit(GetReservedDateFailure(error));
      },
    );
  }
}
