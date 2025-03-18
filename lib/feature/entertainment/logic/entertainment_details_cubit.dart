import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_states.dart';

class EntertainmentDetailsCubit extends Cubit<EntertainmentDetailsStates> {
  final EntertainmentRepository repository;
  EntertainmentDetailsCubit(this.repository) : super(EntertainmentDetailsStatesInitial());
  Future<void> findEntertainmentByID(String id) async {
    final results = await repository.getEntertainmentDetailsByID(entertainmentID: id);
    results.fold((entertainment) {
      safeEmit(EntertainmentDetailsStatesSuccess(entertainment));
    }, (error) {
      safeEmit(EntertainmentDetailsStatesFailure(error));
    });
  }
}
