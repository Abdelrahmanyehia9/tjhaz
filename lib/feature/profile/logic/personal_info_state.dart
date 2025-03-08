import 'package:equatable/equatable.dart';


abstract class PersonalInfoStates   {
  const PersonalInfoStates();


}
class PersonalInfoInitial extends PersonalInfoStates {}

class GetPersonalInfoLoading extends PersonalInfoStates {

}
class GetPersonalInfoSuccess extends PersonalInfoStates {

}
class GetPersonalInfoFailure extends PersonalInfoStates {
  final String errorMsg ;

  const GetPersonalInfoFailure(this.errorMsg);

}



class UpdatePersonalInfoSuccess extends PersonalInfoStates {}
class UpdatePersonalInfoFailure extends PersonalInfoStates {
  final String errorMsg ;

  const UpdatePersonalInfoFailure(this.errorMsg);

}


