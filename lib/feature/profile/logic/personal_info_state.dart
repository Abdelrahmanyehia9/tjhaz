import 'package:equatable/equatable.dart';

import '../../auth/data/models/user_model.dart';

abstract class GetPersonalInfoStates  extends Equatable {
  const GetPersonalInfoStates();

  @override
  List<Object> get props => [];
}
class GetPersonalInfoInitial extends GetPersonalInfoStates {}
class GetPersonalInfoLoading extends GetPersonalInfoStates {

}
class GetPersonalInfoSuccess extends GetPersonalInfoStates {
  final UserModel userModel ;

  const GetPersonalInfoSuccess(this.userModel);
  @override
  // TODO: implement props
  List<Object> get props => [userModel];
}
class GetPersonalInfoFailure extends GetPersonalInfoStates {
  final String errorMsg ;

  const GetPersonalInfoFailure(this.errorMsg);
  @override
  List<Object> get props => [errorMsg];
}
