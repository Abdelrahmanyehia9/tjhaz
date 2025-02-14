import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/feature/auth/logic/login_cubit.dart';
import 'package:tjhaz/feature/auth/logic/reset_password_cubit.dart';
import 'package:tjhaz/feature/auth/logic/signup_cubit.dart';
import 'package:tjhaz/feature/auth/view/screen/forget_password_screen.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_screen.dart';

import '../../feature/auth/view/screen/otp_confirm.dart';
import '../../feature/auth/view/screen/setup_new_password.dart';
import '../../feature/introduction/view/screen/onboarding_screen.dart';

class AppRouter {
  static const authScreen = "/";
  static const onBoardingScreen = "/OnBoardingScreen" ;
  static const confirmOtpScreen = "/confirmOtpScreen" ;
  static const setupNewPasswordScreen = "/setupNewPassword" ;
  static const forgetPasswordPage = "/forgetPasswordScreen" ;

  static GoRouter routes = GoRouter(routes: [
    GoRoute(
      path: authScreen,
      builder: (BuildContext context, GoRouterState state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=>LoginCubit() ) ,
            BlocProvider(create: (context)=>SignupCubit() ) ,

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
      path: onBoardingScreen,
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
      },
    )
  ]);
}
