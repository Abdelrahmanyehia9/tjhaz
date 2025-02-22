import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tjhaz/core/helpers/constants.dart';
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
Future.delayed(Duration(seconds: 3) , (){
  if(mounted){
    GoRouter.of(context).go(AppRouter.onBoardingScreen) ;
  }
}) ;     super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: screenWidth(context),
        height: screenHeight(context),
        alignment: Alignment.center,
        color: AppColors.cWhite,
        child: Image.asset(AppConstants.splashLogo),
      ),
    );
  }
}
