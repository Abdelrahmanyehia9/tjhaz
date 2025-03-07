import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/database/remote/auth_error_handler.dart';
import 'package:tjhaz/core/extention/firebase_exception_handler.dart';
import 'package:tjhaz/feature/auth/data/models/user_model.dart';
import 'package:tjhaz/feature/auth/data/repository/auth_repo.dart';
import 'package:tjhaz/feature/profile/data/repository/user_repository.dart';

 class SignUpRepository extends AuthRepository{

  final FirebaseAuth auth ;
  final UserRepository userRepository ;
  SignUpRepository({required this.auth, required this.userRepository});

Future<Either<UserCredential , String>>signUpUsingEmailAndPassword({required String username  , required String email  , required String password})async{

  try{
    UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password) ;
    UserModel userModel = UserModel(uID: credential.user!.uid, username: username, emailAddress: email);
    await userRepository.addNewUser(userModel: userModel) ;
    return left(credential);
  }
  catch (e) {return right(e.firebaseErrorMessage);}




  }






}