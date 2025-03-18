import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tjhaz/core/routes/index.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/favorite/data/repository/favorite_repository.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/profile/data/repository/user_repository.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';

final GetIt getIt = GetIt.instance ;

void setupGetIt()  {
FirebaseFirestore firestore = FirebaseFirestore.instance;
firestore.settings = const Settings(persistenceEnabled: true , cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(firebaseAuth: getIt.get<FirebaseAuth>()));
getIt.registerLazySingleton<FirebaseFirestore>(() => firestore);
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(firestore: getIt.get<FirebaseFirestore>()));
  getIt.registerLazySingleton<HomeRepository>(()=> HomeRepository(firestore: getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<CategoryRepository>(()=> CategoryRepository( getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<EntertainmentRepository>(()=> EntertainmentRepository(firestore:  getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<ShopRepository>(()=> ShopRepository(firestore:  getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<BookingRepository>(()=> BookingRepository(getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<FavoriteRepository>(()=> FavoriteRepository(getIt.get<FirebaseFirestore>())  ) ;
  getIt.registerLazySingleton<CartRepository>(()=> CartRepository(getIt.get<FirebaseFirestore>())  ) ;


}