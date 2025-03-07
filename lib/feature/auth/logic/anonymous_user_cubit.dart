import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';

class AnonymousUserCubit extends Cubit<bool> {
  final FirebaseAuth firebaseAuth ;
  AnonymousUserCubit(this.firebaseAuth) : super(true);
  void checkAnonymousUser() {
  bool isAnonymous =  SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous)?? true;
    emit(isAnonymous) ;
  }
}