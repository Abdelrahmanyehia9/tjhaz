import 'package:tjhaz/feature/auth/logic/anonymous_user_cubit.dart';
import 'package:tjhaz/feature/cart/data/repository/cart_repository.dart';
import 'package:tjhaz/feature/cart/logic/cart_cubit.dart';

import 'index.dart';

class AppRouter {
  static const splashScreen = "/";
  static const onBoardingScreen = "/onBoardingScreen";
  static const authScreen = "/authScreen";
  static const forgetPasswordPage = "/forgetPasswordScreen";
  static const confirmOtpScreen = "/confirmOtpScreen";
  static const setupNewPasswordScreen = "/setupNewPassword";
  static const homeScreen = "/home";
  static const categoriesScreen = "/categories";
  static const bookingsScreen = "/bookings";
  static const profileScreen = "/profile";
  static const cartScreen = "/cartScreen";
  static const entertainmentDetailsScreen = "/entertainmentDetailsScreen";
  static const entertainmentScreen = "/entertainmentScreen";
  static const shopScreen = "/shopScreen";
  static const shopDetailsScreen = "/shopDetailsScreen";
  static const reservationScreen = "/reservationScreen";
  static const addOnsScreen = "/addOnsScreen";
  static const personalInfoScreen = "/personalInfoScreen";
  static const favoriteScreen = "/favoriteScreen";

  static final GoRouter routes = GoRouter(
    routes: [
      ///splash
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) =>
            fadingTransition(child: SplashScreen()),
      ),
      ///onboarding
      GoRoute(
        path: onBoardingScreen,
        pageBuilder: (context, state) =>
            fadingTransition(child: OnboardingScreen()),
      ),
      ///auth
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
     ///auth related
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

     ///shell routing of home
      ShellRoute(
        builder: (context, state, child) {
          return BlocProvider(
              create: (context)=>AnonymousUserCubit(getIt.get<FirebaseAuth>())..checkAnonymousUser(),
              child: HomeLayoutShell(child: child));
        },

        routes: [
          GoRoute(
            path: AppRouter.homeScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                    HomeTripsCubit(homeRepository: getIt.get<HomeRepository>())
                      ..getHomeTrips(),
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
                child: HomeScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRouter.categoriesScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => CategoriesCubit(getIt.get<CategoryRepository>())
                  ..getCategoriesByParentId("1"),
                child: AllCategoriesScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRouter.bookingsScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => MyBookingsCubit(getIt.get<BookingRepository>())
                  ..getAllBookingsByCategory(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                  ),
                child: MyBookingsScreen(),
              ),
            ),
          ),
          GoRoute(
            path: AppRouter.profileScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                create: (context) => LogoutCubit(getIt.get<LoginRepo>()),
                child: ProfileScreen(),
              ),
            ),
          ),
        ],
      ),
      ///shell routing for auth
      ///cart
      GoRoute(
        path: cartScreen,
        pageBuilder: (context, state) {
          return fadingTransition(
            child: CartScreen(),
          );
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
                      CategoriesCubit( getIt.get<CategoryRepository>() ),),
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
        path: entertainmentDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: EntertainmentDetailsScreen(model: model));
        },
      ),
      /// shopScreen
      GoRoute(
        path: shopScreen,
        pageBuilder: (context, state) {
          final int? activeCat = state.extra as int? ;
          return fadingTransition(
              child: MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => VendorCubit(getIt.get<ShopRepository>())..getAllVendors()) ,
                    BlocProvider(create: (context)=> ProductsCubit(getIt.get<ShopRepository>()))
                  ],

                  child: ShopScreen(activeCategory: activeCat,)));
        },
      ),
      /// singleProductView
      GoRoute(
        path: shopDetailsScreen,
        pageBuilder: (context, state) {
          final ProductModel model = state.extra as ProductModel;
          return fadingTransition(
              child: BlocProvider(
                create: (context)=>RelatedProductsCubit(getIt.get<ShopRepository>()),
                  child: ShopDetailsScreen(model: model)));
        },
      ),
      ///reservation
      GoRoute(
        path: reservationScreen,
        pageBuilder: (context, state) {
          final EntertainmentDetailsModel model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: MultiBlocProvider(
                  providers: [

                    BlocProvider(create: (context)=> GetReservedHoursCubit(getIt.get<BookingRepository>())) ,
                    BlocProvider(create: (context)=> GetReservedDatesCubit(getIt.get<BookingRepository>())),
                  ],

                  child: ReservationScreen(model: model)));
        },
      ),
      GoRoute(
        path: addOnsScreen,
        pageBuilder: (context, state) {
          final EntertainmentDetailsModel model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: AddOnsScreen(model: model)

          )
          ;
        },
      ),
      GoRoute(
        path: personalInfoScreen,
        pageBuilder: (context, state) {
          return fadingTransition(
              child: BlocProvider(
                  create: (context)=> PersonalInfoCubit(getIt.get<UserRepository>()),
                  child: PersonalInfoScreen()));
        },
      ),
      GoRoute(
        path: favoriteScreen,
        pageBuilder: (context, state) {
          return fadingTransition(
              child: FavoriteScreen());
        },
      ),


    ],
  );
}
