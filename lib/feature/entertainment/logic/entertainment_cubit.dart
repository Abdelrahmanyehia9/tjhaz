import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainments_states.dart';

class EntertainmentCubit extends Cubit<EntertainmentsStates> {

  final EntertainmentRepository entertainmentRepository;

  EntertainmentCubit(this.entertainmentRepository,)
      :super(EntertainmentsStatesInitial());


  Future<void> getEntertainmentsByCatID(String catID) async {
    safeEmit(EntertainmentItemsLoading()) ;
    final results = await entertainmentRepository.getEntertainmentsByCategoryID(
        catID: catID);
    results.fold((items) {
      safeEmit(EntertainmentItemsSuccess(items));
    }, (error) {
      safeEmit(EntertainmentItemsFailure(error));
    }) ;
  }



}