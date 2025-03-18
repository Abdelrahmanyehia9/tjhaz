import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_state.dart';
import '../../auth/data/models/user_model.dart';
import '../data/repository/user_repository.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoStates> {
  final UserRepository userRepository;
  UserModel? userModel  ;

  PersonalInfoCubit(this.userRepository) : super(PersonalInfoInitial());

  Future<void> get() async {
    safeEmit(GetPersonalInfoLoading());
    final result = await userRepository.getUserInfo();
    result.fold((user) {
      userModel = user ;
      safeEmit(GetPersonalInfoSuccess())  ;
    }, (error) {
      safeEmit(GetPersonalInfoFailure(error));
    });
  }
  Future<void> update(UserModel userModel)  async {
    final response = await  userRepository.editUserInfo(userModel: userModel);
    response.fold((updatedUser){
      userModel = updatedUser ;
      safeEmit(UpdatePersonalInfoSuccess()) ;
    },(error){
      safeEmit(UpdatePersonalInfoFailure(error)) ;
    } ) ;

  }

}

