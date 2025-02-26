import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/profile/data/repository/user_repository.dart';

final GetIt getIt = GetIt.instance ;

void setupGetIt()  {

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerLazySingleton<HomeRepository>(()=> HomeRepository(firestore: getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<CategoryRepository>(()=> CategoryRepository( getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<EntertainmentRepository>(()=> EntertainmentRepository(firestore:  getIt.get<FirebaseFirestore>())  ) ;


}