import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository{

  final FirebaseAuth auth ;
  AuthRepository({required this.auth});


}