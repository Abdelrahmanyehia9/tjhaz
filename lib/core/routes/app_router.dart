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
import 'package:tjhaz/feature/home/data/repository/home_repository.dart';
import 'package:tjhaz/feature/home/logic/trips_cubit.dart';
import 'package:tjhaz/feature/home/view/screen/grid_view_layout.dart';
import 'package:tjhaz/feature/home/view/screen/home_layout.dart';
import 'package:tjhaz/feature/introduction/view/screen/onboarding_screen.dart';
import 'package:tjhaz/feature/introduction/view/screen/splash_screen.dart';
import 'package:tjhaz/feature/profile/data/repository/user_repository.dart';
import 'package:tjhaz/feature/trip/data/repository/trip_repository.dart';
import 'package:tjhaz/feature/trip/logic/trip_cubit.dart';
import '../../feature/trip/data/model/trip_model.dart';
import '../../feature/trip/view/screen/trip_screen.dart';
import 'navigation_transitions.dart';





class AppRouter {
  static const splashScreen = "/";
  static const authScreen = "/authScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const confirmOtpScreen = "/confirmOtpScreen";
  static const setupNewPasswordScreen = "/setupNewPassword";
  static const forgetPasswordPage = "/forgetPasswordScreen";
  static const homeLayout = "/homeLayout";
  static const gridViewLayout = "/gridview";
  static const tripScreen = "/tripScreen";

  static final GoRouter routes = GoRouter(
    routes: [

      GoRoute(
        path: splashScreen,
        pageBuilder: (context, state) => fadingTransition(child: SplashScreen()),
      ), GoRoute(
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
        path: forgetPasswordPage,
        pageBuilder: (context, state) => fadingTransition(
          child: BlocProvider(
            create: (context) => ResetPasswordCubit(),
            child: ForgetPasswordScreen(),
          ),
        ),
      ),
      GoRoute(
        path: homeLayout,
        pageBuilder: (context, state) => fadingTransition(child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context ) => TripsCubit(homeRepository: getIt.get<HomeRepository>())..getAllTrips() )
          ],
            child: HomeLayout())),
      ),
      GoRoute(
        path: gridViewLayout,
        pageBuilder: (context, state) => fadingTransition(child: GridViewLayout()),
      ),
      GoRoute(
        path: tripScreen,
        pageBuilder: (context, state) {
          final trip = state.extra as String; // Extract object
          return fadingTransition(child: BlocProvider(
            create: (context)=>TripCubit(TripRepository(firestore: getIt.get<FirebaseFirestore>())),
              child: TripScreen(tripID: trip)));
        },
      ),

    ],
  );
}
