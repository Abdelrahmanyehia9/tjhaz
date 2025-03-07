import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/database/local/shared_prefrences_constants.dart';
import '../../../../core/database/local/shared_prefrences_helper.dart';

  class  AuthRepository {


   Future<void> saveUserData(User user) async {
    await SharedPrefHelper.setString(SharedPrefConstants.currentUserId, user.uid);
    await SharedPrefHelper.setString(SharedPrefConstants.currentUserEmail, user.email ?? "");
    await SharedPrefHelper.setBool(SharedPrefConstants.isAnonymous, user.isAnonymous );
  }

}