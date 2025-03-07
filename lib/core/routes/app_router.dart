import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/data/repository/sign_up_repository.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/view/screen/auth_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/forget_password_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/otp_confirm.dart';
import 'package:tjhaz/feature/auth/view/screen/setup_new_password.dart';
import 'package:tjhaz/feature/booking/data/repository/bookings_repository.dart';
import 'package:tjhaz/feature/booking/logic/booking/my_bookings_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_date_cubit.dart';
import 'package:tjhaz/feature/booking/logic/reservation/get_reservation_hours_cubit.dart';
import 'package:tjhaz/feature/booking/view/screen/add_ons_screen.dart';
import 'package:tjhaz/feature/booking/view/screen/reservation_screen.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_cubit.dart';
import 'package:tjhaz/feature/entertainment/view/screen/entertainment_screen.dart';
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/home/logic/banners_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_activities_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_store_cubit.dart';
import 'package:tjhaz/feature/home/logic/home_trips_cubit.dart';
import 'package:tjhaz/feature/home/view/screen/home_layout.dart';
import 'package:tjhaz/feature/introduction/view/screen/onboarding_screen.dart';
import 'package:tjhaz/feature/introduction/view/screen/splash_screen.dart';
import 'package:tjhaz/feature/profile/data/repository/user_repository.dart';
import 'package:tjhaz/feature/auth/logic/logout_cubit.dart';
import 'package:tjhaz/feature/profile/logic/personal_info_cubit.dart';
import 'package:tjhaz/feature/profile/view/screen/personal_info_screen.dart';
import 'package:tjhaz/feature/shop/data/model/product_mode.dart';
import 'package:tjhaz/feature/shop/data/repository/shop_repository.dart';
import 'package:tjhaz/feature/shop/logic/products_cubit.dart';
import 'package:tjhaz/feature/shop/logic/related_products_cubit.dart';
import 'package:tjhaz/feature/shop/logic/vendors_cubit.dart';
import 'package:tjhaz/feature/shop/view/screen/shop_details_screen.dart';
import 'package:tjhaz/feature/shop/view/screen/shop_screen.dart';
import '../../feature/entertainment/view/screen/entertainment_details_screen.dart';
import 'navigation_transitions.dart';



class AppRouter {
  static const splashScreen = "/";
  static const onBoardingScreen = "/onBoardingScreen";
  static const authScreen = "/authScreen";
  static const forgetPasswordPage = "/forgetPasswordScreen";
  static const confirmOtpScreen = "/confirmOtpScreen";
  static const setupNewPasswordScreen = "/setupNewPassword";
  static const homeLayout = "/homeLayout";
  static const entertainmentDetailsScreen = "/entertainmentDetailsScreen";
  static const entertainmentScreen = "/entertainmentScreen";
  static const shopScreen = "/shopScreen" ;
  static const shopDetailsScreen = "/shopDetailsScreen" ;
  static const reservationScreen = "/reservationScreen" ;
  static const addOnsScreen = "/addOnsScreen" ;
 static const personalInfoScreen = "/personalInfoScreen" ;


  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) =>
            fadingTransition(child: SplashScreen()),
      ),
      GoRoute(
        path: onBoardingScreen,
        pageBuilder: (context, state) =>
            fadingTransition(child: OnboardingScreen()),
      ),
      GoRoute(
        path: authScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => LoginCubit(
                      getIt.get<LoginRepo>() )),
              BlocProvider(
                  create: (context) => SignupCubit(SignUpRepository(
                      auth: getIt<FirebaseAuth>(),
                      userRepository: getIt<UserRepository>()))),
            ],
            child: AuthScreen(),
          ),
        ),
      ),
      GoRoute(
        path: forgetPasswordPage,
        pageBuilder: (context, state) => fadingTransition(

            child: ForgetPasswordScreen(),

        ),
      ),
      GoRoute(
        path: confirmOtpScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: OtpConfirmScreen(),
        ),
      ),
      GoRoute(
        path: setupNewPasswordScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: SetupNewPassword(),
        ),
      ),
      GoRoute(
        path: homeLayout,
        pageBuilder: (context, state) {
          final int initialIndex = state.extra as int? ?? 0 ;
          return fadingTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                  HomeTripsCubit(homeRepository: getIt.get<HomeRepository>())
                    ..getHomeTrips(),
                ),
                BlocProvider(
                  create: (context) => LogoutCubit(getIt.get<LoginRepo>())
                ),
                BlocProvider(
                  create: (context) => MyBookingsCubit(getIt.get<BookingRepository>())..getAllBookingsByCategory(userId: FirebaseAuth.instance.currentUser!.uid,),
                ),
                BlocProvider(
                  create: (context) =>
                  CategoriesCubit(getIt.get<CategoryRepository>())..getCategoriesByParentId("1"),
                ),
                BlocProvider(
                  create: (context) => HomeActivitiesCubit(
                      homeRepository: getIt.get<HomeRepository>())
                    ..getHomeActivities(),
                ),
                BlocProvider(
                  create: (context) =>
                  HomeStoresCubit(getIt.get<HomeRepository>())
                    ..getHomeStores(),
                ),
                BlocProvider(
                  create: (context) =>
                  BannerCubit(getIt.get<HomeRepository>())
                    ..getBanners(),
                ),
              ],
              child: HomeLayout( ),
            ),
          );
        },
      ),
      GoRoute(
        path: entertainmentDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: EntertainmentDetailsScreen(model: model));
        },
      ),
      GoRoute(
        path: entertainmentScreen,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;
          final parentCategory = extraData["parent"] as Map<String, String>;
          final active = extraData["active"] as int?;
          return fadingTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) =>
                    CategoriesCubit( getIt.get<CategoryRepository>() ) ,),

                BlocProvider(create: (context) {
                  return EntertainmentCubit(
                      getIt.get<EntertainmentRepository>());
                }),
              ],
              child: EntertainmentScreen(
                parentCategory: parentCategory,
                activeCategory: active,
              ),
            ),
          );
        },
      ),
      GoRoute(
        path: shopScreen,
        pageBuilder: (context, state) {
          final int? activeCategory = state.extra as int?;
          return fadingTransition(child: MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context)=> VendorCubit(getIt.get<ShopRepository>())..getAllVendors()),
                  BlocProvider(create: (context)=> ProductsCubit(getIt.get<ShopRepository>())),
                ],
                child: ShopScreen(activeCategory: activeCategory))  );
        },
      ),
      GoRoute(
        path: shopDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as ProductModel;
          return fadingTransition(child: BlocProvider(
              create: (context) =>RelatedProductsCubit(getIt.get<ShopRepository>()) ,
              child: ShopDetailsScreen(model: model)));
        },
      ),
      GoRoute(
        path: reservationScreen,
        pageBuilder: (context, state) {
          final EntertainmentDetailsModel model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: MultiBlocProvider(
                  providers: [
                    BlocProvider( create: (context)=>GetReservedDatesCubit(getIt.get<BookingRepository>()),) ,
                    BlocProvider( create: (context)=>GetReservedHoursCubit(getIt.get<BookingRepository>()),) ,


                  ],
                  child: ReservationScreen(model: model,)));
        },
      ),
      GoRoute(
        path: addOnsScreen,
        pageBuilder: (context, state) {
          final EntertainmentDetailsModel model  = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: AddOnsScreen(model: model,));
        },
      ),
      GoRoute(
        path: personalInfoScreen,
        pageBuilder: (context, state) {
          return fadingTransition(
              child: BlocProvider(
                create: (context)=>GetPersonalInfoCubit(getIt.get<UserRepository>()),
                  child: PersonalInfoScreen()));
        },
      ),



    ],
  );
}
