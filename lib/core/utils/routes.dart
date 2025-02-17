import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/view/screen/forget_password_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/auth_screen.dart';
import 'package:tjhaz/feature/home/view/screen/grid_view_layout.dart';
import 'package:tjhaz/feature/home/view/widgets/home_app_bar.dart';
import 'package:tjhaz/feature/introduction/view/screen/splash_screen.dart';
import '../../feature/auth/view/screen/otp_confirm.dart';
import '../../feature/auth/view/screen/setup_new_password.dart';
import '../../feature/home/view/screen/home_layout.dart';
import '../../feature/introduction/view/screen/onboarding_screen.dart';

class AppRouter {
  static const splashScreen = "/" ;
  static const authScreen = "/authScreen";
  static const onBoardingScreen = "/OnBoardingScreen" ;
  static const confirmOtpScreen = "/confirmOtpScreen" ;
  static const setupNewPasswordScreen = "/setupNewPassword" ;
  static const forgetPasswordPage = "/forgetPasswordScreen" ;
  static const homeLayout = "/homeLayout" ;
  static const gridViewLayout = "/gridview" ;

  static GoRouter routes = GoRouter(routes: [
    GoRoute(
      path: splashScreen,
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ) ,
    GoRoute(
      path: onBoardingScreen,
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
      },
    ) ,
    GoRoute(
      path: authScreen,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=>LoginCubit(getIt.get<FirebaseAuth>()) ) ,
            BlocProvider(create: (context)=>SignupCubit(getIt.get<FirebaseAuth>() , getIt.get<FirebaseFirestore>()    ) ) ,

          ],
          child: AuthScreen(),
         );
      },
    ),
    GoRoute(
      path: confirmOtpScreen,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(create: (context)=>ResetPasswordCubit(),
            child: OtpConfirmScreen());
      },
    ),
    GoRoute(
      path: setupNewPasswordScreen,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(create: (context)=>ResetPasswordCubit(),
            child: SetupNewPassword());
      },
    ),
    GoRoute(
      path: forgetPasswordPage,
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(create: (context)=>ResetPasswordCubit(),
            child: ForgetPasswordScreen());
      },
    ) ,

    GoRoute(
      path: homeLayout,
      builder: (BuildContext context, GoRouterState state) {
        return HomeLayout();
      },
    ) ,
    GoRoute(
      path: gridViewLayout,
      builder: (BuildContext context, GoRouterState state) {
        return GridViewLayout();
      },
    ) ,


  ]);
}
