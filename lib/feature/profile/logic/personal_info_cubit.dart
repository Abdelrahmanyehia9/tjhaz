import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_state.dart';
import '../../auth/data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoStates> {
  final UserRepository userRepository;
  UserModel? userModel  ;

  PersonalInfoCubit(this.userRepository) : super(PersonalInfoInitial());

  Future<void> get(String uID) async {
    emit(GetPersonalInfoLoading());
    final result = await userRepository.getUserInfo(userID: uID);
    result.fold((user) {
      userModel = user ;
      emit(GetPersonalInfoSuccess())  ;
    }, (error) {
      emit(GetPersonalInfoFailure(error));
    });
  }
  Future<void> update(UserModel userModel)  async {
    final response = await  userRepository.editUserInfo(userModel: userModel);
    response.fold((updatedUser){
      userModel = updatedUser ;
      emit(UpdatePersonalInfoSuccess()) ;
    },(error){
      emit(UpdatePersonalInfoFailure(error)) ;
    } ) ;

  }

}

