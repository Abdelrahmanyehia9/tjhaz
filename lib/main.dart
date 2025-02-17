import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tjhaz/core/DI/dependency_injection.dart';
import 'package:tjhaz/core/styles/colors.dart';
import 'package:tjhaz/core/utils/routes.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  runApp(TjhazApp());
}

class TjhazApp extends StatelessWidget {
  const TjhazApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 852),
      child: MaterialApp.router(
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

