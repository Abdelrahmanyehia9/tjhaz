import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/extention/safe_emit.dart';

class AnonymousUserCubit extends Cubit<bool> {
  final FirebaseAuth firebaseAuth ;
  AnonymousUserCubit(this.firebaseAuth) : super(true);
  void checkAnonymousUser() {
  bool isAnonymous =  SharedPrefHelper.getBool(SharedPrefConstants.isAnonymous)?? true;
    safeEmit(isAnonymous) ;
  }
}