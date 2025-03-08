import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_constants.dart';
import 'package:tjhaz/core/database/local/shared_prefrences_helper.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/utils/screen_size.dart';

import '../../../../core/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        splashScreenNavigation() ;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        alignment: Alignment.center,
        color: AppColors.cWhite,
        child: Image.asset(AppAssets.splashLogo),
      ),
    );
  }

  void splashScreenNavigation() {
    bool isFirstTime =
        SharedPrefHelper.getBool(SharedPrefConstants.isFirstTime) ?? true;
    bool isLoggedIn =
        SharedPrefHelper.getString(SharedPrefConstants.currentUserId) == null
            ? false
            : true;
    if (isFirstTime) {
      GoRouter.of(context).go(AppRouter.onBoardingScreen);
    } else {
      if (isLoggedIn) {
        GoRouter.of(context).go(AppRouter.homeLayout);
      } else {
        GoRouter.of(context).go(AppRouter.authScreen);
      }
    }
  }
}
