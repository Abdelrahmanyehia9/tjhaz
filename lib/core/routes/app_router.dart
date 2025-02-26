import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/feature/auth/data/repository/login_repo.dart';
import 'package:tjhaz/feature/auth/data/repository/sign_up_repository.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/view/screen/auth_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/forget_password_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/otp_confirm.dart';
import 'package:tjhaz/feature/auth/view/screen/setup_new_password.dart';
import 'package:tjhaz/feature/categories/data/model/cateory_model.dart';
import 'package:tjhaz/feature/categories/data/repository/categories_repository.dart';
import 'package:tjhaz/feature/categories/logic/categories_cubit.dart';
import 'package:tjhaz/feature/categories/logic/entertainment_categories_cubit.dart';
import 'package:tjhaz/feature/entertainment/data/model/entertainment_details_model.dart';
import 'package:tjhaz/feature/entertainment/data/repository/entertainment_repository.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_cubit.dart';
import 'package:tjhaz/feature/entertainment/logic/entertainment_details_cubit.dart';
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

  static final GoRouter routes = GoRouter(
    routes: [
      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) => fadingTransition(child: SplashScreen()),
      ),
      GoRoute(
        path: onBoardingScreen,
        pageBuilder: (context, state) => fadingTransition(child: OnboardingScreen()),
      ),
      GoRoute(
        path: authScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) =>
                  LoginCubit(LoginRepo(firebaseAuth: getIt<FirebaseAuth>()))),
              BlocProvider(create: (context) =>
                  SignupCubit(SignUpRepository(
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
          child: BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: ForgetPasswordScreen(),
          ),
        ),
      ),
      GoRoute(
        path: confirmOtpScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: OtpConfirmScreen(),
          ),
        ),
      ),
      GoRoute(
        path: setupNewPasswordScreen,
        pageBuilder: (context, state) => fadingTransition(
          child: BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: SetupNewPassword(),
          ),
        ),
      ),
      GoRoute(
        path: homeLayout,
        pageBuilder: (context, state) => fadingTransition(child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => EntertainmentCategoriesCubit(getIt.get<CategoryRepository>()) ) ,
            BlocProvider(create: (context) => CategoriesCubit(getIt.get<CategoryRepository>())..getCategoriesByParentId("1") ) ,
            BlocProvider(create: (context ) => HomeTripsCubit(homeRepository: getIt.get<HomeRepository>())..getHomeTrips()),
             BlocProvider(create: (context ) => HomeActivitiesCubit(homeRepository: getIt.get<HomeRepository>())..getHomeActivities()),
             BlocProvider(create: (context ) => HomeStoresCubit(getIt.get<HomeRepository>())..getHomeStores()),
             BlocProvider(create: (context ) => BannerCubit(getIt.get<HomeRepository>())..getBanners()),
             BlocProvider(create: (context ) => EntertainmentDetailsCubit(getIt.get<EntertainmentRepository>())),

          ],
            child: HomeLayout())),
      ),
      GoRoute(
        path: entertainmentDetailsScreen,
        pageBuilder: (context, state) {
          final model = state.extra as EntertainmentDetailsModel; // Extract object
          return fadingTransition(child: BlocProvider(
            create: (context)=>EntertainmentDetailsCubit(EntertainmentRepository(firestore: getIt.get<FirebaseFirestore>())),
              child: EntertainmentDetailsScreen(model: model))

          );
        },
      ),
      GoRoute(
        path: entertainmentScreen,
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;
          final subCategoryId = extraData["id"] as String;
          final name = extraData["name"] as String;
          final categories = extraData["categories"] as List<CategoryModel>;

          return fadingTransition(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => EntertainmentCategoriesCubit(getIt.get<CategoryRepository>())),
                BlocProvider(create: (context) => EntertainmentCubit(getIt.get<EntertainmentRepository>())),
              ],
              child: EntertainmentScreen(catID: subCategoryId, categories: categories  , name : name ),
            ),
          );
        },
      ),


    ],
  );
}
