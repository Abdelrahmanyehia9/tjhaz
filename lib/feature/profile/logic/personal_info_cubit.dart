import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_state.dart';

import '../data/repository/user_repository.dart';

class GetPersonalInfoCubit extends Cubit<GetPersonalInfoStates> {
  final UserRepository userRepository;

  GetPersonalInfoCubit(this.userRepository) : super(GetPersonalInfoInitial());

  Future<void> get(String uID) async {
    emit(GetPersonalInfoLoading());
    final result = await userRepository.getUserInfo(userID: uID);
    result.fold((user) {
      emit(GetPersonalInfoSuccess(user));
    }, (error) {
      emit(GetPersonalInfoFailure(error));
    });
  }

}
