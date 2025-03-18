import 'package:flutter/material.dart';
import 'package:tjhaz/core/utils/app_assets.dart';
import 'package:tjhaz/core/utils/app_strings.dart';
import 'package:tjhaz/feature/auth/view/screen/login_screen.dart';
import 'package:tjhaz/feature/auth/view/screen/signup_screen.dart';
import 'package:tjhaz/feature/auth/view/widgets/auth_header.dart';

import '../../../../core/widgets/toggle_pages.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(tittle: Image.asset(AppAssets.appLogo)) ,
             TogglePages(pages: const [LoginScreen() , SignupScreen()] , title: [AppStrings.login , AppStrings.signUp],)
          ],
        ),
      ),
    );
  }
}
