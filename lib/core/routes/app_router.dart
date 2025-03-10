
import 'index.dart';

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
 static const favoriteScreen = "/favoriteScreen" ;


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
      ///forget password
      GoRoute(
        path: forgetPasswordPage,
        pageBuilder: (context, state) => fadingTransition(

            child: ForgetPasswordScreen(),

        ),
      ),
      ///confirm otp
      GoRoute(
        path: confirmOtpScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: OtpConfirmScreen(),
        ),
      ),
      ///setup new password
      GoRoute(
        path: setupNewPasswordScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: SetupNewPassword(),
        ),
      ),
      ///home
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
              child: HomeLayout(initialIndex: initialIndex, ),
            ),
          );
        },
      ),
      ///entertainment
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

      ///entertainment  details
      GoRoute(
        path: entertainmentDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: EntertainmentDetailsScreen(model: model));
        },
      ),
      ///shop
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
      ///shop details
      GoRoute(
        path: shopDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as ProductModel;
          return fadingTransition(child: BlocProvider(
              create: (context) =>RelatedProductsCubit(getIt.get<ShopRepository>()) ,
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
                    BlocProvider( create: (context)=>GetReservedDatesCubit(getIt.get<BookingRepository>()),) ,
                    BlocProvider( create: (context)=>GetReservedHoursCubit(getIt.get<BookingRepository>()),) ,


                  ],
                  child: ReservationScreen(model: model,)));
        },
      ),
      ///add ons
      GoRoute(
        path: addOnsScreen,
        pageBuilder: (context, state) {
          final EntertainmentDetailsModel model  = state.extra as EntertainmentDetailsModel;
          return fadingTransition(
              child: AddOnsScreen(model: model,));
        },
      ),
      ///profile
      GoRoute(
        path: personalInfoScreen,
        pageBuilder: (context, state) {
          return fadingTransition(
              child: BlocProvider(
                create: (context)=>PersonalInfoCubit(getIt.get<UserRepository>()),
                  child: PersonalInfoScreen()));
        },
      ),
      ///favorite
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
