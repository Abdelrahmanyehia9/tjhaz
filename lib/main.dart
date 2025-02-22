import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'core/routes/app_router.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  runApp(EasyLocalization(

      supportedLocales: [Locale('en', 'US'), Locale('ar', 'KW')],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      child: TjhazApp()));
}

class TjhazApp extends StatelessWidget {
  const TjhazApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),

      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor ,
        splashColor: Colors.transparent ,
        fontFamily: 'alex',
        highlightColor: Colors.transparent , hoverColor: Colors.transparent ,
      ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.routes,
      ),
    );
  }
}

